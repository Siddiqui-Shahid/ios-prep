import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';

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
          appBar: AppBar(title: Text(day.title)),
          body: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: day.chapters.length,
            separatorBuilder: (_, _) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final chapter = day.chapters[index];
              final done = progress.isChapterComplete(
                week.id,
                day.id,
                chapter.id,
              );
              final section = progress.sectionProgress(
                week.id,
                day.id,
                chapter.id,
              );
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: done
                        ? const Icon(Icons.check)
                        : Text('${index + 1}'),
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
            },
          ),
        );
      },
    );
  }
}
