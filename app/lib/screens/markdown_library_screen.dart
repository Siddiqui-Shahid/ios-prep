import 'package:flutter/material.dart';

import '../models/models.dart';

class MarkdownLibraryScreen extends StatefulWidget {
  const MarkdownLibraryScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.weeks,
    required this.outcomes,
    required this.onOpenChapter,
  });

  final String title;
  final String subtitle;
  final List<WeekRef> weeks;
  final List<String> outcomes;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  @override
  State<MarkdownLibraryScreen> createState() => _MarkdownLibraryScreenState();
}

class _MarkdownLibraryScreenState extends State<MarkdownLibraryScreen> {
  String _query = '';

  bool _matches(DayRef day) {
    final query = _query.trim().toLowerCase();
    if (query.isEmpty) return true;
    return day.title.toLowerCase().contains(query) ||
        day.chapters.any(
          (chapter) => chapter.title.toLowerCase().contains(query),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 880),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 48),
            children: [
              Text(
                widget.subtitle,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              _OutcomePanel(outcomes: widget.outcomes),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) => setState(() => _query = value),
                decoration: const InputDecoration(
                  hintText: 'Search the Markdown library',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              const SizedBox(height: 24),
              for (final week in widget.weeks) ...[
                if (week.days.any(_matches)) ...[
                  Text(
                    week.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  for (final day in week.days.where(_matches)) ...[
                    _DayLessons(
                      week: week,
                      day: day,
                      onOpenChapter: widget.onOpenChapter,
                    ),
                    const SizedBox(height: 10),
                  ],
                  const SizedBox(height: 18),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _OutcomePanel extends StatelessWidget {
  const _OutcomePanel({required this.outcomes});

  final List<String> outcomes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D0D0D),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF343434)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'What this section prepares you for',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          for (final outcome in outcomes)
            Padding(
              padding: const EdgeInsets.only(bottom: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(Icons.check, size: 17),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      outcome,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _DayLessons extends StatelessWidget {
  const _DayLessons({
    required this.week,
    required this.day,
    required this.onOpenChapter,
  });

  final WeekRef week;
  final DayRef day;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  @override
  Widget build(BuildContext context) {
    if (day.chapters.length == 1) {
      final chapter = day.chapters.first;
      return Card(
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: const Icon(Icons.description_outlined),
          title: Text(
            chapter.title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: const Text('Markdown document'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => onOpenChapter(
            ChapterLocation(week: week, day: day, chapter: chapter),
          ),
        ),
      );
    }

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: const Icon(Icons.folder_open_outlined),
        title: Text(
          day.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text('${day.chapters.length} Markdown lessons'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => _MarkdownDayScreen(
                week: week,
                day: day,
                onOpenChapter: onOpenChapter,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MarkdownDayScreen extends StatelessWidget {
  const _MarkdownDayScreen({
    required this.week,
    required this.day,
    required this.onOpenChapter,
  });

  final WeekRef week;
  final DayRef day;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lessons')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 40),
            children: [
              Text(
                day.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Tap a lesson to open the full Markdown document.',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              for (var index = 0; index < day.chapters.length; index++) ...[
                Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 9,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(
                      day.chapters[index].title,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    subtitle: const Text('Open Markdown document'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () => onOpenChapter(
                      ChapterLocation(
                        week: week,
                        day: day,
                        chapter: day.chapters[index],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
