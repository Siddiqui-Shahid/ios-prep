import 'package:flutter/material.dart';

import '../data/content_catalog.dart';
import '../data/progress_store.dart';
import '../data/reminder_store.dart';
import '../models/models.dart';
import 'day_screen.dart';
import 'flashcards_screen.dart';
import 'progress_screen.dart';
import 'reminders_screen.dart';
import 'revision_screen.dart';
import 'system_design_screen.dart';
import 'track_screen.dart';

const _paper = Colors.black;
const _ink = Colors.white;
const _rule = Colors.white;
const _romans = ['I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'];

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.catalog,
    required this.progress,
    required this.player,
    required this.onOpenChapter,
  });

  final ContentCatalog catalog;
  final ProgressStore progress;
  final Object player;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  ChapterLocation? _continuePage() {
    final bookmark = progress.bookmark;
    if (bookmark != null) {
      final loc = catalog.manifest.findChapter(
        bookmark.weekId,
        bookmark.dayId,
        bookmark.chapterId,
      );
      if (loc != null) return loc;
    }
    final spine = catalog.spine;
    for (final loc in spine) {
      if (!progress.isChapterComplete(
            loc.week.id,
            loc.day.id,
            loc.chapter.id,
          ) &&
          !progress.isChapterManuallyComplete(
            loc.week.id,
            loc.day.id,
            loc.chapter.id,
          )) {
        return loc;
      }
    }
    return spine.isEmpty ? null : spine.first;
  }

  static String _partBlurb(String id) {
    switch (id) {
      case 'part-01-front':
        return 'How this book works, and how to sit with it for 60–90 minutes.';
      case 'part-02-weak':
        return 'Gaps from your recorded interviews — say these out loud until they stick.';
      case 'part-03-craft':
        return 'iOS you must speak: memory, lists, networking, production, DSA.';
      case 'part-04-method':
        return 'How to run LLD (class-level) and HLD (system-level) in a room.';
      case 'part-05-samples':
        return 'Full sample designs: feed, images, HTTP, sync, chat, checkout, and more.';
      case 'part-06-thirty':
        return 'Thirty machine-design questions with speakable answers.';
      case 'part-07-sessions':
        return 'Trip sittings. Pick one before you board. Each is 60–90 minutes.';
      default:
        return 'Open this part and read in order.';
    }
  }

  void _openPart(BuildContext context, WeekRef book, DayRef day) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DayScreen(
          week: book,
          day: day,
          progress: progress,
          onOpenChapter: onOpenChapter,
        ),
      ),
    );
  }

  void _openArchive(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Old 4-week Q&A dump'),
                subtitle: const Text('Not the handbook. Extra practice only.'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TrackScreen(
                        title: 'Archived 4-week sample Q&A',
                        subtitle:
                            'Not the handbook spine. Extra practice only.',
                        weeks: catalog.weeks,
                        progress: progress,
                        onOpenChapter: onOpenChapter,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Revision packs'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => RevisionScreen(
                        weeks: catalog.revisionWeeks,
                        progress: progress,
                        onOpenChapter: onOpenChapter,
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Flashcards'),
                onTap: () {
                  Navigator.pop(ctx);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => FlashcardsScreen(
                        weeks: catalog.flashcardWeeks,
                        progress: progress,
                        onOpenChapter: onOpenChapter,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final book = catalog.handbook;
    final spine = catalog.spine;
    final text = Theme.of(context).textTheme;

    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        final cont = _continuePage();
        final done = book == null
            ? 0
            : spine
                  .where(
                    (l) =>
                        progress.isChapterComplete(
                          l.week.id,
                          l.day.id,
                          l.chapter.id,
                        ) ||
                        progress.isChapterManuallyComplete(
                          l.week.id,
                          l.day.id,
                          l.chapter.id,
                        ),
                  )
                  .length;
        return Scaffold(
          backgroundColor: _paper,
          appBar: AppBar(
            backgroundColor: _paper,
            foregroundColor: _ink,
            title: const Text('Handbook'),
            actions: [
              IconButton(
                tooltip: 'Progress',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProgressScreen(
                        weeks: catalog.weeks,
                        handbookWeeks: catalog.handbookWeeks,
                        guideWeeks: catalog.guideWeeks,
                        topicWeeks: catalog.topicWeeks,
                        weakPointWeeks: catalog.weakPointWeeks,
                        questionWeeks: catalog.questionWeeks,
                        systemDesignWeeks: catalog.systemDesignWeeks,
                        revisionWeeks: catalog.revisionWeeks,
                        flashcardWeeks: catalog.flashcardWeeks,
                        progress: progress,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.insights_outlined),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'reminders') {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const RemindersRoute()),
                    );
                  } else if (value == 'archive') {
                    _openArchive(context);
                  }
                },
                itemBuilder: (_) => const [
                  PopupMenuItem(value: 'reminders', child: Text('Reminders')),
                  PopupMenuItem(value: 'archive', child: Text('Archive')),
                ],
              ),
            ],
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 48),
                children: [
                  Text(
                    'iOS INTERVIEW HANDBOOK',
                    style: text.labelLarge?.copyWith(
                      letterSpacing: 2.2,
                      color: _rule,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Read this like a book.',
                    style: text.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: _ink,
                      height: 1.15,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Seven parts, one order. Open a part, then a page. '
                    'On the Mumbai–Pune ride, give it 60–90 minutes — not the whole journey. '
                    'Mark complete when you can explain the page out loud.',
                    style: text.bodyLarge?.copyWith(
                      height: 1.55,
                      color: _ink.withValues(alpha: 0.78),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    spine.isEmpty
                        ? 'No pages bundled.'
                        : '$done of ${spine.length} pages marked',
                    style: text.bodyMedium?.copyWith(
                      color: _rule,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (cont != null) ...[
                    const SizedBox(height: 22),
                    _CoverCta(
                      kicker: progress.bookmark == null
                          ? 'Start at the beginning'
                          : 'Continue',
                      title: cont.chapter.title,
                      subtitle: cont.day.title,
                      onTap: () => onOpenChapter(cont),
                    ),
                  ],
                  if (catalog.systemDesignWeeks.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _SystemDesignCta(
                      count: catalog.systemDesignWeeks.fold<int>(
                        0,
                        (total, week) =>
                            total +
                            week.days.fold<int>(
                              0,
                              (sum, day) => sum + day.chapters.length,
                            ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => SystemDesignScreen(
                              weeks: catalog.systemDesignWeeks,
                              progress: progress,
                              onOpenChapter: onOpenChapter,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 36),
                  Text(
                    'The book',
                    style: text.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: _ink,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Tap a part. Pages live inside. This is the table of contents — not a dashboard.',
                    style: text.bodyMedium?.copyWith(
                      height: 1.4,
                      color: _ink.withValues(alpha: 0.65),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (book != null)
                    for (var i = 0; i < book.days.length; i++) ...[
                      if (i > 0) const SizedBox(height: 10),
                      _PartCard(
                        roman: i < _romans.length ? _romans[i] : '${i + 1}',
                        title: book.days[i].title,
                        blurb: _partBlurb(book.days[i].id),
                        pageCount: book.days[i].chapters.length,
                        onTap: () => _openPart(context, book, book.days[i]),
                      ),
                    ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SystemDesignCta extends StatelessWidget {
  const _SystemDesignCta({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0D0D0D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.white),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                child: Icon(Icons.account_tree_outlined),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'System Design Lab',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$count real mobile case studies · guided path · search',
                      style: TextStyle(
                        color: _ink.withValues(alpha: 0.68),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward, color: _ink),
            ],
          ),
        ),
      ),
    );
  }
}

class _PartCard extends StatelessWidget {
  const _PartCard({
    required this.roman,
    required this.title,
    required this.blurb,
    required this.pageCount,
    required this.onTap,
  });

  final String roman;
  final String title;
  final String blurb;
  final int pageCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0D0D0D),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF343434)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 36,
                child: Text(
                  roman,
                  style: const TextStyle(
                    color: _rule,
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      blurb,
                      style: TextStyle(
                        color: _ink.withValues(alpha: 0.68),
                        height: 1.4,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$pageCount ${pageCount == 1 ? 'page' : 'pages'}',
                      style: const TextStyle(
                        color: _rule,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: _ink.withValues(alpha: 0.35)),
            ],
          ),
        ),
      ),
    );
  }
}

class _CoverCta extends StatelessWidget {
  const _CoverCta({
    required this.kicker,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final String kicker;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kicker.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black54,
                  letterSpacing: 1.4,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }
}

class RemindersRoute extends StatelessWidget {
  const RemindersRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    return RemindersScreen(store: app.reminders);
  }
}

class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.reminders, required super.child});

  final ReminderStore reminders;

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      reminders != oldWidget.reminders;
}
