import 'package:flutter/material.dart';

import '../data/content_catalog.dart';
import '../data/progress_store.dart';
import '../data/reminder_store.dart';
import '../models/models.dart';
import '../services/tts_player_service.dart';
import 'day_screen.dart';
import 'progress_screen.dart';
import 'reminders_screen.dart';

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
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        final bookmark = progress.bookmark;
        return Scaffold(
          appBar: AppBar(
            title: const Text('iOS Prep Audiobook'),
            actions: [
              IconButton(
                tooltip: 'Progress',
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ProgressScreen(
                        weeks: weeks,
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
                'Sample Q&A · Week 1 (Days 01–07)',
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
              const SizedBox(height: 20),
              for (final week in weeks) ...[
                Text(week.title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Week progress',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: progress.weekProgress(week),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(progress.weekProgress(week) * 100).round()}% complete',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ...week.days.map((day) {
                  final pct = progress.dayProgress(day, week.id);
                  return Card(
                    child: ListTile(
                      title: Text(day.title),
                      subtitle: Text(
                        '${(pct * 100).round()}% · ${day.chapters.length} chapters',
                      ),
                      trailing: SizedBox(
                        width: 36,
                        height: 36,
                        child: CircularProgressIndicator(
                          value: pct == 0 ? null : pct,
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
                const SizedBox(height: 24),
              ],
            ],
          ),
        );
      },
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
  bool updateShouldNotify(AppScope oldWidget) => reminders != oldWidget.reminders;
}
