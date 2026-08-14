import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({
    super.key,
    required this.weeks,
    required this.progress,
    this.revisionWeeks = const [],
    this.flashcardWeeks = const [],
  });

  final List<WeekRef> weeks;
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
              Text(
                'Sample Q&A',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              ..._weekCards(context, weeks, initiallyExpandFirst: true),
              if (revisionWeeks.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Revision',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(context, revisionWeeks, initiallyExpandFirst: false),
              ],
              if (flashcardWeeks.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Flashcards',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                ..._weekCards(context, flashcardWeeks, initiallyExpandFirst: false),
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
                          color: done ? const Color(0xFF0B6E4F) : null,
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
