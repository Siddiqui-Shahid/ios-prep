import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';
import 'day_screen.dart';

/// Revision day guides — outcome, concept refresh, map-to-work, flash prompts.
class RevisionScreen extends StatelessWidget {
  const RevisionScreen({
    super.key,
    required this.weeks,
    required this.progress,
    required this.onOpenChapter,
  });

  final List<WeekRef> weeks;
  final ProgressStore progress;
  final Future<void> Function(ChapterLocation location, {int section})
      onOpenChapter;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Revision')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Day guides',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Compact revision passes: outcomes, critical truths, map to your work, and flash prompts. Same reader as Sample Q&A.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              for (var i = 0; i < weeks.length; i++)
                _RevisionWeekSection(
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

class _RevisionWeekSection extends StatelessWidget {
  const _RevisionWeekSection({
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
        subtitle: Text(
          '${(pct * 100).round()}% · ${week.days.length} day guides',
        ),
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
                        '${(dayPct * 100).round()}% · day guide',
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
                        if (day.chapters.length == 1) {
                          final chapter = day.chapters.first;
                          final section = progress.sectionProgress(
                            week.id,
                            day.id,
                            chapter.id,
                          );
                          onOpenChapter(
                            ChapterLocation(
                              week: week,
                              day: day,
                              chapter: chapter,
                            ),
                            section: section,
                          );
                          return;
                        }
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
