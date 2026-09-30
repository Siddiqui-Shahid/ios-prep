import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';
import '../widgets/manual_complete.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({
    super.key,
    required this.weeks,
    required this.progress,
    this.handbookWeeks = const [],
    this.guideWeeks = const [],
    this.topicWeeks = const [],
    this.weakPointWeeks = const [],
    this.questionWeeks = const [],
    this.systemDesignWeeks = const [],
    this.revisionWeeks = const [],
    this.flashcardWeeks = const [],
  });

  final List<WeekRef> weeks;
  final List<WeekRef> handbookWeeks;
  final List<WeekRef> guideWeeks;
  final List<WeekRef> topicWeeks;
  final List<WeekRef> weakPointWeeks;
  final List<WeekRef> questionWeeks;
  final List<WeekRef> systemDesignWeeks;
  final List<WeekRef> revisionWeeks;
  final List<WeekRef> flashcardWeeks;
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
              if (handbookWeeks.isNotEmpty) ...[
                Text(
                  'Handbook',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(
                  context,
                  handbookWeeks,
                  initiallyExpandFirst: true,
                ),
              ],
              if (guideWeeks.isNotEmpty) ...[
                Text(
                  'Trips (legacy lists)',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(context, guideWeeks, initiallyExpandFirst: true),
              ],
              if (weakPointWeeks.isNotEmpty) ...[
                Text(
                  'Weak points',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(
                  context,
                  weakPointWeeks,
                  initiallyExpandFirst: false,
                ),
              ],
              if (topicWeeks.isNotEmpty) ...[
                Text('Topics', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ..._weekCards(context, topicWeeks, initiallyExpandFirst: false),
              ],
              if (questionWeeks.isNotEmpty) ...[
                Text(
                  '30 machine design questions',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(
                  context,
                  questionWeeks,
                  initiallyExpandFirst: false,
                ),
              ],
              if (systemDesignWeeks.isNotEmpty) ...[
                Text(
                  'System Design Lab',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(
                  context,
                  systemDesignWeeks,
                  initiallyExpandFirst: false,
                ),
              ],
              Text(
                'Archived 4-week sample Q&A',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ..._weekCards(context, weeks, initiallyExpandFirst: false),
              if (revisionWeeks.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Revision',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(
                  context,
                  revisionWeeks,
                  initiallyExpandFirst: false,
                ),
              ],
              if (flashcardWeeks.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Flashcards',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(
                  context,
                  flashcardWeeks,
                  initiallyExpandFirst: false,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  List<Widget> _weekCards(
    BuildContext context,
    List<WeekRef> source, {
    required bool initiallyExpandFirst,
  }) {
    return [
      for (var i = 0; i < source.length; i++) ...[
        Card(
          clipBehavior: Clip.antiAlias,
          child: ExpansionTile(
            initiallyExpanded: initiallyExpandFirst && i == 0,
            maintainState: true,
            title: Text(source[i].title),
            subtitle: Text(
              '${(progress.weekProgress(source[i]) * 100).round()}% of chapters complete',
            ),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: LinearProgressIndicator(
                  value: progress.weekProgress(source[i]),
                ),
              ),
              ...source[i].days.map((day) {
                final week = source[i];
                final pct = progress.dayProgress(day, week.id);
                return ExpansionTile(
                  title: Text(day.title),
                  subtitle: Text('${(pct * 100).round()}%'),
                  leading: ManualCompleteIcon(
                    progress: progress,
                    id: ProgressStore.dayCompleteId(week.id, day.id),
                  ),
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
                      leading: IconButton(
                        tooltip: done ? 'Mark as unread' : 'Mark as read',
                        icon: Icon(
                          done
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: done ? Colors.white : null,
                        ),
                        onPressed: () async {
                          await progress.setChapterComplete(
                            week.id,
                            day.id,
                            c.id,
                            complete: !done,
                          );
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                done ? 'Marked unread' : 'Marked as read',
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      title: Text(c.title),
                      subtitle: Text(
                        done
                            ? 'Complete · tap check to unread'
                            : 'Section ${section + 1} · tap to mark read',
                      ),
                      onTap: () async {
                        await progress.setChapterComplete(
                          week.id,
                          day.id,
                          c.id,
                          complete: !done,
                        );
                      },
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    ];
  }
}
