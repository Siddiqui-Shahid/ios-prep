import 'package:flutter/material.dart';

import '../data/content_catalog.dart';
import '../data/progress_store.dart';
import '../models/models.dart';
import 'markdown_library_screen.dart';

/// Intentionally small: Markdown is the product, this screen is only the door.
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
  final Object player;
  final Future<void> Function(ChapterLocation location, {int section})
  onOpenChapter;

  int _lessonCount(List<WeekRef> weeks) => weeks.fold(
    0,
    (total, week) =>
        total +
        week.days.fold(0, (dayTotal, day) => dayTotal + day.chapters.length),
  );

  List<WeekRef> _swiftWeeks() {
    return [
      for (final week in catalog.weeks)
        WeekRef(
          id: week.id,
          title: week.title,
          days: [
            for (final day in week.days)
              DayRef(
                id: day.id,
                title: day.title,
                codeFiles: day.codeFiles,
                chapters: day.chapters
                    .where(
                      (chapter) =>
                          !chapter.id.contains('system-design-mock') &&
                          !chapter.title.toLowerCase().contains(
                            'system-design mock',
                          ),
                    )
                    .toList(),
              ),
          ],
        ),
    ];
  }

  List<WeekRef> _orderedSystemDesigns() {
    const order = [
      'cheatsheet',
      'generic-mobile-problems',
      'networking-layer',
      'image-loading-library',
      'offline-sync-engine',
      'authentication-oauth-biometric',
      'mobile-security-privacy-engine',
      'analytics-sdk',
      'feature-flag-system',
      'crash-reporting-sdk',
      'app-modularization',
      'social-feed',
      'messaging-chat',
      'video-feed-streaming',
      'payment-checkout',
    ];
    final rank = {for (var i = 0; i < order.length; i++) order[i]: i};
    return [
      for (final week in catalog.systemDesignWeeks)
        WeekRef(
          id: week.id,
          title: week.title,
          days: [...week.days]
            ..sort((a, b) => (rank[a.id] ?? 999).compareTo(rank[b.id] ?? 999)),
        ),
    ];
  }

  void _openLibrary(
    BuildContext context, {
    required String title,
    required String subtitle,
    required List<WeekRef> weeks,
    required List<String> outcomes,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MarkdownLibraryScreen(
          title: title,
          subtitle: subtitle,
          weeks: weeks,
          outcomes: outcomes,
          onOpenChapter: onOpenChapter,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final swiftWeeks = _swiftWeeks();
    final designWeeks = _orderedSystemDesigns();
    final swiftLessons = _lessonCount(swiftWeeks);
    final designLessons = _lessonCount(designWeeks);
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('iOS Interview Prep')),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            children: [
              Text(
                'LEARN FROM THE DOCUMENTS',
                style: text.labelLarge?.copyWith(
                  letterSpacing: 2,
                  color: Colors.white70,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Two sections. No dashboard.',
                style: text.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Read the Markdown lessons in order, explain each idea aloud, '
                'and use the examples as interview answers. There are no scores, '
                'rings, streaks, or completion controls in the way.',
                style: text.bodyLarge?.copyWith(
                  color: Colors.white70,
                  height: 1.55,
                ),
              ),
              const SizedBox(height: 30),
              _LibraryCard(
                number: '01',
                title: 'Swift Basics',
                description:
                    'Swift language, memory, concurrency, UIKit, SwiftUI, networking, architecture, testing, performance, DSA, security, and interview communication.',
                meta: '28 study days · $swiftLessons Markdown lessons',
                onTap: () => _openLibrary(
                  context,
                  title: 'Swift Basics',
                  subtitle:
                      'A four-week iOS interview curriculum. Start at Week 1 and read in order, or search for the topic you need.',
                  weeks: swiftWeeks,
                  outcomes: const [
                    'Explain Swift, ARC, concurrency, and actors clearly',
                    'Build UIKit and SwiftUI features with sound architecture',
                    'Handle networking, persistence, testing, and performance',
                    'Solve DSA and behavioral questions while thinking aloud',
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _LibraryCard(
                number: '02',
                title: 'System Designs',
                description:
                    'Production-grade mobile designs with requirements, architecture, data models, APIs, Swift examples, trade-offs, failure handling, and mock interview questions.',
                meta: '$designLessons complete Markdown case studies',
                onTap: () => _openLibrary(
                  context,
                  title: 'System Designs',
                  subtitle:
                      'Begin with the Master Cheatsheet, then study reusable platform systems before complete product designs.',
                  weeks: designWeeks,
                  outcomes: const [
                    'Run a structured 45-minute system-design interview',
                    'Defend APIs, storage, caching, sync, and concurrency choices',
                    'Design for offline use, failures, security, and observability',
                    'Discuss scale and mobile constraints with concrete trade-offs',
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF3A3A3A)),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.menu_book_outlined),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Reading rule: after every heading, close the app and explain it in your own words. Re-open the lesson, find what you missed, and repeat.',
                        style: TextStyle(height: 1.5, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  const _LibraryCard({
    required this.number,
    required this.title,
    required this.description,
    required this.meta,
    required this.onTap,
  });

  final String number;
  final String title;
  final String description;
  final String meta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    child: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(color: Colors.white70, height: 1.5),
              ),
              const SizedBox(height: 16),
              Text(
                meta,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
