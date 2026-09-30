import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';
import '../widgets/manual_complete.dart';
import 'code_lab_screen.dart';

class DayScreen extends StatelessWidget {
  const DayScreen({
    super.key,
    required this.week,
    required this.day,
    required this.progress,
    required this.onOpenChapter,
  });

  final WeekRef week;
  final DayRef day;
  final ProgressStore progress;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(day.title),
            actions: [
              if (day.codeFiles.isNotEmpty)
                IconButton(
                  tooltip: 'Lesson code',
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CodeLabScreen(day: day),
                      ),
                    );
                  },
                  icon: const Icon(Icons.code),
                ),
            ],
          ),
          body: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 880),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
                children: [
                  ManualCompleteButton(
                    progress: progress,
                    id: ProgressStore.dayCompleteId(week.id, day.id),
                    label: _completeLabel(week.id),
                  ),
                  const SizedBox(height: 16),
                  for (var index = 0; index < day.chapters.length; index++) ...[
                    if (index > 0) const SizedBox(height: 8),
                    _chapterCard(context, index),
                  ],
                  if (day.codeFiles.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Lesson code',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Swift demos and sketches for this day.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    for (final file in day.codeFiles) ...[
                      Card(
                        child: ListTile(
                          leading: const CircleAvatar(
                            child: Icon(Icons.code, size: 20),
                          ),
                          title: Text(file.title),
                          subtitle: Text(
                            file.language == 'swift' ? 'Swift lab' : 'Notes',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CodeLabScreen(
                                  day: day,
                                  initialFileId: file.id,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static String _completeLabel(String weekId) {
    return switch (weekId) {
      'trips-mumbai-pune' => 'Mark this trip complete',
      'study-topics' => 'Mark this topic complete',
      'interview-weak-points' => 'Mark this drill complete',
      'machine-design-30' => 'Mark these questions complete',
      _ => 'Mark complete',
    };
  }

  Future<void> _toggleRead(
    BuildContext context,
    ChapterRef chapter,
    bool currentlyDone,
  ) async {
    await progress.setChapterComplete(
      week.id,
      day.id,
      chapter.id,
      complete: !currentlyDone,
    );
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(currentlyDone ? 'Marked unread' : 'Marked as read'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _chapterCard(BuildContext context, int index) {
    final chapter = day.chapters[index];
    final done = progress.isChapterComplete(week.id, day.id, chapter.id);
    final section = progress.sectionProgress(week.id, day.id, chapter.id);
    return Card(
      child: ListTile(
        leading: Tooltip(
          message: done ? 'Mark as unread' : 'Mark as read',
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () => _toggleRead(context, chapter, done),
            child: CircleAvatar(
              backgroundColor: done
                  ? Colors.white
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              foregroundColor: done
                  ? Colors.black
                  : Theme.of(context).colorScheme.onSurface,
              child: done ? const Icon(Icons.check) : Text('${index + 1}'),
            ),
          ),
        ),
        title: Text(chapter.title),
        subtitle: Text(
          done
              ? 'Completed · tap check to unread'
              : section > 0
              ? 'Resume section ${section + 1}'
              : 'Not started · tap # to mark read',
        ),
        trailing: FittedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ManualCompleteIcon(
                progress: progress,
                id: ProgressStore.chapterCompleteId(
                  week.id,
                  day.id,
                  chapter.id,
                ),
              ),
              IconButton(
                tooltip: done ? 'Mark as unread' : 'Mark as read',
                icon: Icon(
                  done ? Icons.check_circle : Icons.radio_button_unchecked,
                  color: done ? Colors.white : null,
                ),
                onPressed: () => _toggleRead(context, chapter, done),
              ),
            ],
          ),
        ),
        onTap: () => onOpenChapter(
          ChapterLocation(week: week, day: day, chapter: chapter),
          section: section,
        ),
      ),
    );
  }
}
