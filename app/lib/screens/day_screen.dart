import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';
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
          appBar: AppBar(
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
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
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
        );
      },
    );
  }

  Widget _chapterCard(BuildContext context, int index) {
    final chapter = day.chapters[index];
    final done = progress.isChapterComplete(week.id, day.id, chapter.id);
    final section = progress.sectionProgress(week.id, day.id, chapter.id);
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: done ? const Icon(Icons.check) : Text('${index + 1}'),
        ),
        title: Text(chapter.title),
        subtitle: Text(
          done
              ? 'Completed'
              : section > 0
                  ? 'Resume section ${section + 1}'
                  : 'Not started',
        ),
        trailing: const Icon(Icons.headphones),
        onTap: () => onOpenChapter(
          ChapterLocation(week: week, day: day, chapter: chapter),
          section: section,
        ),
      ),
    );
  }
}
