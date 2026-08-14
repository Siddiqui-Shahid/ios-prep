import 'package:audio_service/audio_service.dart';
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
    _boot();
  }

  Future<void> _boot() async {
    try {
      tz_data.initializeTimeZones();
      try {
        tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
      } catch (_) {
        // Fall back to local if Asia/Kolkata isn't available.
        tz.setLocalLocation(tz.local);
      }

      final prefs = await SharedPreferences.getInstance();
      final notifications = FlutterLocalNotificationsPlugin();

      // Don't block first paint on permission dialogs.
      await notifications.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
          ),
        ),
      );
      await notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              'study_reminders',
              'Study reminders',
              description: 'iOS interview prep study reminders',
              importance: Importance.high,
            ),
          );

      final player = await AudioService.init(
        builder: TtsPlayerService.new,
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.iosprep.audiobook.tts',
          androidNotificationChannelName: 'Audiobook playback',
          androidNotificationOngoing: true,
          androidStopForegroundOnPause: true,
        ),
      );

      final catalog = await ContentCatalog.load();
      final progress = ProgressStore(prefs);
      final reminders = ReminderStore(prefs, notifications);

      // Preferences / TTS voice can be slow on Android — don't hang boot.
      final accent =
          progress.voiceAccent == 'gb' ? VoiceAccent.gb : VoiceAccent.us;
      await player
          .configurePreferences(
            speed: progress.playbackSpeed,
            accent: accent,
          )
          .timeout(const Duration(seconds: 4), onTimeout: () {});

      // Fire-and-forget: permissions + reminder reschedule after UI is up.
      Future<void>(() async {
        try {
          await notifications
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.requestNotificationsPermission();
          await notifications
              .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin>()
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
    } catch (e, st) {
      debugPrint('Bootstrap failed: $e\n$st');
      if (!mounted) return;
      setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF0B6E4F);
    if (_app != null) return _app!;

    return MaterialApp(
      title: 'iOS Prep Audiobook',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: seed),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _error == null
                ? const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: seed),
                      SizedBox(height: 16),
                      Text('Loading iOS Prep…'),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.error_outline, size: 40, color: seed),
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
    const seed = Color(0xFF0B6E4F);
    final lightScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    ).copyWith(
      primary: seed,
      secondary: seed,
      tertiary: seed,
    );
    final darkScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    ).copyWith(
      primary: const Color(0xFF5FBF9A),
      secondary: const Color(0xFF5FBF9A),
    );

    return AppScope(
      reminders: reminders,
      child: MaterialApp(
        title: 'iOS Prep Audiobook',
        theme: ThemeData(
          colorScheme: lightScheme,
          useMaterial3: true,
          listTileTheme: const ListTileThemeData(
            selectedColor: Color(0xFF111111),
            selectedTileColor: Color(0xFFFFEB3B),
            iconColor: Color(0xFF0B6E4F),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF0B6E4F),
          ),
          segmentedButtonTheme: SegmentedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFFFFEB3B);
                }
                return null;
              }),
              foregroundColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return const Color(0xFF111111);
                }
                return null;
              }),
            ),
          ),
        ),
        darkTheme: ThemeData(
          colorScheme: darkScheme,
          useMaterial3: true,
          listTileTheme: const ListTileThemeData(
            selectedColor: Color(0xFF111111),
            selectedTileColor: Color(0xFFFFEB3B),
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: Color(0xFF5FBF9A),
          ),
        ),
        home: _AppShell(
          catalog: catalog,
          progress: progress,
          player: player,
        ),
      ),
    );
  }
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
  }) async {
    final markdown = await widget.catalog.loadMarkdownWithEmbeddedCode(
      location.chapter,
      location.day,
    );
    final sections =
        await widget.catalog.loadScriptSections(location.chapter);
    final accent =
        widget.progress.voiceAccent == 'gb' ? VoiceAccent.gb : VoiceAccent.us;
    await widget.player
        .configurePreferences(
          speed: widget.progress.playbackSpeed,
          accent: accent,
        )
        .timeout(const Duration(seconds: 3), onTimeout: () {});

    if (!mounted) return;
    await _navKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => ReaderScreen(
          week: location.week,
          day: location.day,
          chapter: location.chapter,
          markdown: markdown,
          sections: sections,
          player: widget.player,
          initialSection: section,
          initialMode: widget.progress.readerMode == 'read'
              ? ReaderMode.read
              : ReaderMode.listen,
          initialComplete: widget.progress.isChapterComplete(
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
          onAccentChanged: (a) => widget.progress.setVoiceAccent(
            a == VoiceAccent.gb ? 'gb' : 'us',
          ),
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
          },
        ),
      ),
    );
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
