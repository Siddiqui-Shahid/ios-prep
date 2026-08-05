import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({
    super.key,
    required this.weeks,
    required this.progress,
  });

  final List<WeekRef> weeks;
  final ProgressStore progress;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Progress')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              for (final week in weeks) ...[
                Text(
                  week.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(value: progress.weekProgress(week)),
                const SizedBox(height: 8),
                Text(
                  '${(progress.weekProgress(week) * 100).round()}% of ${week.title} chapters complete',
                ),
                const SizedBox(height: 12),
                ...week.days.map((day) {
                  final pct = progress.dayProgress(day, week.id);
                  return ExpansionTile(
                    title: Text(day.title),
                    subtitle: Text('${(pct * 100).round()}%'),
                    children: day.chapters.map((c) {
                      final done = progress.isChapterComplete(
                        week.id,
                        day.id,
                        c.id,
                      );
                      final section = progress.sectionProgress(
                        week.id,
                        day.id,
                        c.id,
                      );
                      return ListTile(
                        dense: true,
                        leading: Icon(
                          done
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: done ? const Color(0xFF0B6E4F) : null,
                        ),
                        title: Text(c.title),
                        subtitle: Text(
                          done
                              ? 'Complete'
                              : 'Section ${section + 1}',
                        ),
                      );
                    }).toList(),
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
