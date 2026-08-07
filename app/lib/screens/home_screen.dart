import 'package:flutter/material.dart';

import '../data/content_catalog.dart';
import '../data/progress_store.dart';
import '../data/reminder_store.dart';
import '../models/models.dart';
import '../services/tts_player_service.dart';
import 'day_screen.dart';
import 'flashcards_screen.dart';
import 'progress_screen.dart';
import 'reminders_screen.dart';
import 'revision_screen.dart';

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
  final TtsPlayerService player;
  final Future<void> Function(ChapterLocation location, {int section})
      onOpenChapter;

  @override
  Widget build(BuildContext context) {
    final weeks = catalog.weeks;
    final revisionWeeks = catalog.revisionWeeks;
    final flashcardWeeks = catalog.flashcardWeeks;
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        final bookmark = progress.bookmark;
        return Scaffold(
          appBar: AppBar(
            title: const Text('iOS Prep Audiobook'),
            actions: [
              if (revisionWeeks.isNotEmpty)
                IconButton(
                  tooltip: 'Revision',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RevisionScreen(
                          weeks: revisionWeeks,
                          progress: progress,
                          onOpenChapter: onOpenChapter,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.menu_book_outlined),
                ),
              if (flashcardWeeks.isNotEmpty)
                IconButton(
                  tooltip: 'Flashcards',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => FlashcardsScreen(
                          weeks: flashcardWeeks,
                          progress: progress,
                          onOpenChapter: onOpenChapter,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.style_outlined),
                ),
              IconButton(
                tooltip: 'Progress',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProgressScreen(
                        weeks: weeks,
                        revisionWeeks: revisionWeeks,
                        flashcardWeeks: flashcardWeeks,
                        progress: progress,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.insights_outlined),
              ),
              IconButton(
                tooltip: 'Reminders',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const RemindersRoute(),
                    ),
                  );
                },
                icon: const Icon(Icons.alarm),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Interview prep audiobook',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Listen with on-device speech up to 16x, follow the chapter on screen, and resume offline anytime.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              if (bookmark != null) ...[
                const SizedBox(height: 16),
                Card(
                  color: const Color(0xFFFFEB3B),
                  child: ListTile(
                    leading: const Icon(
                      Icons.play_circle_fill,
                      color: Color(0xFF111111),
                    ),
                    title: const Text(
                      'Continue where you left off',
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${bookmark.dayTitle.isEmpty ? bookmark.dayId : bookmark.dayTitle}\n'
                      '${bookmark.chapterTitle.isEmpty ? bookmark.chapterId : bookmark.chapterTitle} · section ${bookmark.sectionIndex + 1}',
                      style: const TextStyle(color: Color(0xFF111111)),
                    ),
                    isThreeLine: true,
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFF111111),
                    ),
                    onTap: () {
                      final loc = catalog.manifest.findChapter(
                        bookmark.weekId,
                        bookmark.dayId,
                        bookmark.chapterId,
                      );
                      if (loc != null) {
                        onOpenChapter(loc, section: bookmark.sectionIndex);
                      }
                    },
                  ),
                ),
              ],
              if (revisionWeeks.isNotEmpty) ...[
                const SizedBox(height: 16),
                Card(
                  color: const Color(0xFF0B6E4F),
                  child: ListTile(
                    leading: const Icon(
                      Icons.menu_book,
                      color: Color(0xFFFFFFFF),
                    ),
                    title: const Text(
                      'Revision',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${revisionWeeks.fold<int>(0, (n, w) => n + w.days.length)} day guides · outcomes, truths, map to your work',
                      style: const TextStyle(color: Color(0xFFE8FFF6)),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFFFFFFFF),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RevisionScreen(
                            weeks: revisionWeeks,
                            progress: progress,
                            onOpenChapter: onOpenChapter,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              if (flashcardWeeks.isNotEmpty) ...[
                const SizedBox(height: 12),
                Card(
                  color: const Color(0xFF14532D),
                  child: ListTile(
                    leading: const Icon(
                      Icons.style,
                      color: Color(0xFFFFFFFF),
                    ),
                    title: const Text(
                      'Flashcards',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${flashcardWeeks.fold<int>(0, (n, w) => n + w.days.length)} packs · speak prompts cold, listen to reveal',
                      style: const TextStyle(color: Color(0xFFE8FFF6)),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right,
                      color: Color(0xFFFFFFFF),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => FlashcardsScreen(
                            weeks: flashcardWeeks,
                            progress: progress,
                            onOpenChapter: onOpenChapter,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Text(
                'Sample Q&A',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              for (var i = 0; i < weeks.length; i++)
                _WeekSection(
                  week: weeks[i],
                  progress: progress,
                  initiallyExpanded: i == 0,
                  onOpenChapter: onOpenChapter,
                ),
            ],
          ),
        );
      },
    );
  }
}

class _WeekSection extends StatelessWidget {
  const _WeekSection({
    required this.week,
    required this.progress,
    required this.initiallyExpanded,
    required this.onOpenChapter,
  });

  final WeekRef week;
  final ProgressStore progress;
  final bool initiallyExpanded;
  final Future<void> Function(ChapterLocation location, {int section})
      onOpenChapter;

  @override
  Widget build(BuildContext context) {
    final pct = progress.weekProgress(week);
    return Card(
      margin: const EdgeInsets.only(top: 12),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: initiallyExpanded,
        maintainState: true,
        title: Text(week.title),
        subtitle: Text('${(pct * 100).round()}% complete'),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(value: pct),
                const SizedBox(height: 12),
                ...week.days.map((day) {
                  final dayPct = progress.dayProgress(day, week.id);
                  return Card(
                    elevation: 0,
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest
                        .withValues(alpha: 0.45),
                    child: ListTile(
                      title: Text(day.title),
                      subtitle: Text(
                        '${(dayPct * 100).round()}% · ${day.chapters.length} chapters',
                      ),
                      trailing: SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          value: dayPct == 0 ? null : dayPct,
                          strokeWidth: 3,
                          color: const Color(0xFF0B6E4F),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DayScreen(
                              week: week,
                              day: day,
                              progress: progress,
                              onOpenChapter: onOpenChapter,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Thin route so reminders can access inherited stores from AppState.
class RemindersRoute extends StatelessWidget {
  const RemindersRoute({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppScope.of(context);
    return RemindersScreen(store: app.reminders);
  }
}

class AppScope extends InheritedWidget {
  const AppScope({
    super.key,
    required this.reminders,
    required super.child,
  });

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
