import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import 'data/content_catalog.dart';
import 'data/progress_store.dart';
import 'data/reminder_store.dart';
import 'models/models.dart';
import 'screens/home_screen.dart';
import 'screens/reader_screen.dart';
import 'services/tts_player_service.dart';
import 'widgets/progress_ring.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Paint something immediately — heavy init must not leave a blank screen.
  runApp(const _BootstrapApp());
}

class _BootstrapApp extends StatefulWidget {
  const _BootstrapApp();

  @override
  State<_BootstrapApp> createState() => _BootstrapAppState();
}

class _BootstrapAppState extends State<_BootstrapApp> {
  Object? _error;
  IosPrepApp? _app;

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      WidgetsBinding.instance.ensureSemantics();
    }
    _boot();
  }

  Future<void> _boot() async {
    try {
      await _bootInner().timeout(const Duration(seconds: 12));
    } catch (e, st) {
      debugPrint('Bootstrap failed: $e\n$st');
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  Future<void> _bootInner() async {
    tz_data.initializeTimeZones();
    try {
      tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    } catch (_) {
      // Fall back to local if Asia/Kolkata isn't available.
      tz.setLocalLocation(tz.local);
    }

    final prefs = await SharedPreferences.getInstance().timeout(
      const Duration(seconds: 4),
    );
    final notifications = FlutterLocalNotificationsPlugin();

    // Don't block first paint on permission dialogs. Time out so web never
    // sits on an infinite spinner if a plugin has no implementation.
    try {
      await notifications
          .initialize(
            settings: const InitializationSettings(
              android: AndroidInitializationSettings('@mipmap/ic_launcher'),
              iOS: DarwinInitializationSettings(
                requestAlertPermission: false,
                requestBadgePermission: false,
                requestSoundPermission: false,
              ),
            ),
          )
          .timeout(const Duration(seconds: 3));
    } catch (_) {}
    try {
      await notifications
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              'study_reminders',
              'Study reminders',
              description: 'iOS interview prep study reminders',
              importance: Importance.high,
            ),
          );
    } catch (_) {}

    // AudioService.init can hang forever on web/Chrome. Never block catalog.
    final catalog = await ContentCatalog.load();
    final player = await _createPlayer();
    final progress = ProgressStore(prefs);
    final reminders = ReminderStore(prefs, notifications);

    // Preferences / TTS voice can be slow on Android — don't hang boot.
    final accent = progress.voiceAccent == 'gb'
        ? VoiceAccent.gb
        : VoiceAccent.us;
    await player
        .configurePreferences(speed: progress.playbackSpeed, accent: accent)
        .timeout(const Duration(seconds: 4), onTimeout: () {});

    // Fire-and-forget: permissions + reminder reschedule after UI is up.
    Future<void>(() async {
      try {
        await notifications
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
        await notifications
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
        await reminders.rescheduleAll();
      } catch (_) {}
    });

    if (!mounted) return;
    setState(() {
      _app = IosPrepApp(
        catalog: catalog,
        progress: progress,
        reminders: reminders,
        player: player,
      );
    });
  }

  static Future<TtsPlayerService> _createPlayer() async {
    if (kIsWeb) {
      return TtsPlayerService();
    }
    try {
      return await AudioService.init(
        builder: TtsPlayerService.new,
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.iosprep.audiobook.tts',
          androidNotificationChannelName: 'Audiobook playback',
          androidNotificationOngoing: true,
          androidStopForegroundOnPause: true,
        ),
      ).timeout(const Duration(seconds: 4));
    } catch (_) {
      return TtsPlayerService();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_app != null) return _app!;

    return MaterialApp(
      title: 'iOS Handbook',
      theme: _monochromeTheme(),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _error == null
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ProgressRing(value: 0.35, size: 48),
                      SizedBox(height: 16),
                      Text('Opening the handbook…'),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 40),
                      const SizedBox(height: 12),
                      Text(
                        'Could not start the app.\n$_error',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () {
                          setState(() {
                            _error = null;
                            _app = null;
                          });
                          _boot();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class IosPrepApp extends StatelessWidget {
  const IosPrepApp({
    super.key,
    required this.catalog,
    required this.progress,
    required this.reminders,
    required this.player,
  });

  final ContentCatalog catalog;
  final ProgressStore progress;
  final ReminderStore reminders;
  final TtsPlayerService player;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      reminders: reminders,
      child: MaterialApp(
        title: 'iOS Handbook',
        theme: _monochromeTheme(),
        darkTheme: _monochromeTheme(),
        themeMode: ThemeMode.dark,
        home: _AppShell(catalog: catalog, progress: progress, player: player),
      ),
    );
  }
}

ThemeData _monochromeTheme() {
  const scheme = ColorScheme.dark(
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Color(0xFFD6D6D6),
    onSecondary: Colors.black,
    surface: Colors.black,
    onSurface: Colors.white,
    surfaceContainerLowest: Colors.black,
    surfaceContainerLow: Color(0xFF080808),
    surfaceContainer: Color(0xFF101010),
    surfaceContainerHigh: Color(0xFF171717),
    surfaceContainerHighest: Color(0xFF242424),
    outline: Color(0xFF9A9A9A),
    outlineVariant: Color(0xFF3A3A3A),
    error: Colors.white,
    onError: Colors.black,
  );
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: Colors.black,
    canvasColor: Colors.black,
    useMaterial3: true,
    visualDensity: VisualDensity.standard,
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF0D0D0D),
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF343434)),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),
    listTileTheme: const ListTileThemeData(
      textColor: Colors.white,
      iconColor: Colors.white,
      selectedColor: Colors.black,
      selectedTileColor: Colors.white,
    ),
    dividerColor: const Color(0xFF343434),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
      linearTrackColor: Color(0xFF343434),
      circularTrackColor: Color(0xFF343434),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFF141414),
      hintStyle: const TextStyle(color: Color(0xFF999999)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFF3A3A3A)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white, width: 1.5),
      ),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected) ? Colors.white : null;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? Colors.black
              : Colors.white;
        }),
      ),
    ),
  );
}

class _AppShell extends StatefulWidget {
  const _AppShell({
    required this.catalog,
    required this.progress,
    required this.player,
  });

  final ContentCatalog catalog;
  final ProgressStore progress;
  final TtsPlayerService player;

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  final _navKey = GlobalKey<NavigatorState>();

  Future<void> _openChapter(
    ChapterLocation location, {
    int section = 0,
    bool replace = false,
  }) async {
    final markdown = await widget.catalog.loadMarkdownWithEmbeddedCode(
      location.chapter,
      location.day,
    );
    final sections = await widget.catalog.loadScriptSections(location.chapter);
    final accent = widget.progress.voiceAccent == 'gb'
        ? VoiceAccent.gb
        : VoiceAccent.us;
    await widget.player
        .configurePreferences(
          speed: widget.progress.playbackSpeed,
          accent: accent,
        )
        .timeout(const Duration(seconds: 3), onTimeout: () {});

    if (!mounted) return;
    final spine = widget.catalog.spine;
    final idx = widget.catalog.manifest.spineIndexOf(location);
    final prev = idx != null && idx > 0 ? spine[idx - 1] : null;
    final next = idx != null && idx < spine.length - 1 ? spine[idx + 1] : null;
    final page = MaterialPageRoute(
      builder: (_) => ReaderScreen(
        week: location.week,
        day: location.day,
        chapter: location.chapter,
        markdown: markdown,
        sections: sections,
        player: widget.player,
        initialSection: section,
        spineIndex: idx,
        spineLength: spine.length,
        previousTitle: prev?.chapter.title,
        nextTitle: next?.chapter.title,
        onOpenPrevious: prev == null
            ? null
            : () => _openChapter(prev, replace: true),
        onOpenNext: next == null
            ? null
            : () => _openChapter(next, replace: true),
        initialMode: (kIsWeb || widget.progress.readerMode == 'read')
            ? ReaderMode.read
            : ReaderMode.listen,
        initialComplete:
            widget.progress.isChapterComplete(
              location.week.id,
              location.day.id,
              location.chapter.id,
            ) ||
            widget.progress.isChapterManuallyComplete(
              location.week.id,
              location.day.id,
              location.chapter.id,
            ),
        onBookmark: (sectionIndex) async {
          await widget.progress.saveBookmark(
            Bookmark(
              weekId: location.week.id,
              dayId: location.day.id,
              chapterId: location.chapter.id,
              sectionIndex: sectionIndex,
              updatedAt: DateTime.now(),
              chapterTitle: location.chapter.title,
              dayTitle: location.day.title,
            ),
          );
        },
        onSpeedChanged: widget.progress.setPlaybackSpeed,
        onAccentChanged: (a) =>
            widget.progress.setVoiceAccent(a == VoiceAccent.gb ? 'gb' : 'us'),
        onModeChanged: (mode) => widget.progress.setReaderMode(
          mode == ReaderMode.read ? 'read' : 'listen',
        ),
        onSectionProgress: (sectionIndex) async {
          await widget.progress.saveBookmark(
            Bookmark(
              weekId: location.week.id,
              dayId: location.day.id,
              chapterId: location.chapter.id,
              sectionIndex: sectionIndex,
              updatedAt: DateTime.now(),
              chapterTitle: location.chapter.title,
              dayTitle: location.day.title,
            ),
          );
          // Auto-mark read when the last section is reached (listen or read).
          if (sections.isNotEmpty && sectionIndex >= sections.length - 1) {
            await widget.progress.markChapterComplete(
              location.week.id,
              location.day.id,
              location.chapter.id,
            );
          }
        },
        onChapterCompleted: () async {
          await widget.progress.markChapterComplete(
            location.week.id,
            location.day.id,
            location.chapter.id,
          );
        },
        onSetComplete: (complete) async {
          await widget.progress.setChapterComplete(
            location.week.id,
            location.day.id,
            location.chapter.id,
            complete: complete,
          );
          await widget.progress.setManualComplete(
            ProgressStore.chapterCompleteId(
              location.week.id,
              location.day.id,
              location.chapter.id,
            ),
            complete: complete,
          );
        },
      ),
    );
    final nav = _navKey.currentState;
    if (nav == null) return;
    if (replace) {
      await nav.pushReplacement(page);
    } else {
      await nav.push(page);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Nested Navigator owns day/reader routes. Intercept system back so it
    // pops that stack instead of exiting the MaterialApp (single-route) shell.
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        final nav = _navKey.currentState;
        if (nav != null && nav.canPop()) {
          nav.pop();
        } else {
          SystemNavigator.pop();
        }
      },
      child: Navigator(
        key: _navKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => HomeScreen(
              catalog: widget.catalog,
              progress: widget.progress,
              player: widget.player,
              onOpenChapter: _openChapter,
            ),
          );
        },
      ),
    );
  }
}
