import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';
import '../widgets/manual_complete.dart';
import '../widgets/progress_ring.dart';
import 'day_screen.dart';

/// Generic week/day browser used by archived Q&A and the 30 questions.
class TrackScreen extends StatelessWidget {
  const TrackScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.weeks,
    required this.progress,
    required this.onOpenChapter,
  });

  final String title;
  final String subtitle;
  final List<WeekRef> weeks;
  final ProgressStore progress;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListenableBuilder(
        listenable: progress,
        builder: (context, _) {
          return Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
                children: [
                  Text(subtitle, style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  for (final week in weeks) ...[
                    _WeekCard(
                      week: week,
                      progress: progress,
                      onOpenChapter: onOpenChapter,
                    ),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _WeekCard extends StatelessWidget {
  const _WeekCard({
    required this.week,
    required this.progress,
    required this.onOpenChapter,
  });

  final WeekRef week;
  final ProgressStore progress;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pct = progress.weekProgress(week);
    return Card(
      color: scheme.surface,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    week.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                ProgressRing(value: pct),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(value: pct, minHeight: 6),
            ),
            const SizedBox(height: 8),
            for (final day in week.days)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(day.title),
                subtitle: Text(
                  '${day.chapters.length} '
                  '${day.chapters.length == 1 ? 'chapter' : 'chapters'} · '
                  '${(progress.dayProgress(day, week.id) * 100).round()}%',
                ),
                trailing: ManualCompleteIcon(
                  progress: progress,
                  id: ProgressStore.dayCompleteId(week.id, day.id),
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
          ],
        ),
      ),
    );
  }
}
