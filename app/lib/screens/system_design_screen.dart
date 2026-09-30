import 'package:flutter/material.dart';

import '../data/progress_store.dart';
import '../models/models.dart';
import '../widgets/progress_ring.dart';

/// A focused, searchable entrance to the long-form system-design library.
class SystemDesignScreen extends StatefulWidget {
  const SystemDesignScreen({
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
  State<SystemDesignScreen> createState() => _SystemDesignScreenState();
}

class _SystemDesignScreenState extends State<SystemDesignScreen> {
  static const _learningPath = [
    'cheatsheet',
    'generic-mobile-problems',
    'networking-layer',
    'image-loading-library',
    'offline-sync-engine',
    'social-feed',
    'messaging-chat',
    'payment-checkout',
  ];

  String _query = '';
  String _category = 'All';

  List<ChapterLocation> get _designs => [
    for (final week in widget.weeks)
      for (final day in week.days)
        for (final chapter in day.chapters)
          ChapterLocation(week: week, day: day, chapter: chapter),
  ];

  bool _isDone(ChapterLocation design) {
    return widget.progress.isChapterComplete(
          design.week.id,
          design.day.id,
          design.chapter.id,
        ) ||
        widget.progress.isChapterManuallyComplete(
          design.week.id,
          design.day.id,
          design.chapter.id,
        );
  }

  ChapterLocation? get _nextDesign {
    final byId = {for (final design in _designs) design.day.id: design};
    for (final id in _learningPath) {
      final design = byId[id];
      if (design != null && !_isDone(design)) return design;
    }
    for (final design in _designs) {
      if (!_isDone(design)) return design;
    }
    return _designs.isEmpty ? null : _designs.first;
  }

  @override
  Widget build(BuildContext context) {
    final categories = <String>{
      'All',
      for (final design in _designs) _categoryFor(design.day.id),
    }.toList();

    return ListenableBuilder(
      listenable: widget.progress,
      builder: (context, _) {
        final designs = _designs;
        final completed = designs.where(_isDone).length;
        final filtered = designs.where((design) {
          final category = _categoryFor(design.day.id);
          final query = _query.trim().toLowerCase();
          final matchesCategory = _category == 'All' || category == _category;
          final matchesQuery =
              query.isEmpty ||
              design.chapter.title.toLowerCase().contains(query) ||
              design.day.id.replaceAll('-', ' ').contains(query) ||
              category.toLowerCase().contains(query);
          return matchesCategory && matchesQuery;
        }).toList();

        return Scaffold(
          appBar: AppBar(title: const Text('System Design Lab')),
          body: Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _OverviewCard(
                            completed: completed,
                            total: designs.length,
                            next: _nextDesign,
                            onOpen: widget.onOpenChapter,
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Use the same interview shape every time',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 10),
                          const _FrameworkStrip(),
                          const SizedBox(height: 24),
                          TextField(
                            onChanged: (value) =>
                                setState(() => _query = value),
                            decoration: InputDecoration(
                              hintText: 'Search designs, patterns, or topics',
                              prefixIcon: const Icon(Icons.search),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(14),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                for (final category in categories) ...[
                                  ChoiceChip(
                                    label: Text(category),
                                    selected: _category == category,
                                    onSelected: (_) {
                                      setState(() => _category = category);
                                    },
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _category == 'All'
                                      ? 'All case studies'
                                      : _category,
                                  style: Theme.of(context).textTheme.titleLarge
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                              ),
                              Text('${filtered.length} designs'),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  if (filtered.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text('No designs match this search.'),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                      sliver: SliverList.separated(
                        itemCount: filtered.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final design = filtered[index];
                          final done = _isDone(design);
                          final section = widget.progress.sectionProgress(
                            design.week.id,
                            design.day.id,
                            design.chapter.id,
                          );
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 7,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: done
                                    ? const Color(0xFF0B6E4F)
                                    : Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                                foregroundColor: done ? Colors.white : null,
                                child: Icon(
                                  done ? Icons.check : _iconFor(design.day.id),
                                ),
                              ),
                              title: Text(
                                design.chapter.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              subtitle: Text(
                                '${_categoryFor(design.day.id)} · '
                                '${done
                                    ? 'Completed'
                                    : section > 0
                                    ? 'Resume section ${section + 1}'
                                    : 'Offline case study'}',
                              ),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () => widget.onOpenChapter(
                                design,
                                section: section,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _OverviewCard extends StatelessWidget {
  const _OverviewCard({
    required this.completed,
    required this.total,
    required this.next,
    required this.onOpen,
  });

  final int completed;
  final int total;
  final ChapterLocation? next;
  final Future<void> Function(ChapterLocation location, {int section}) onOpen;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;
    return Card(
      color: const Color(0xFF0B6E4F),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Learn decisions, not diagrams',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                ProgressRing(
                  value: progress,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.white24,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Start with the method, learn reusable mobile patterns, then practise complete systems. Every case study works offline and can be read or listened to.',
              style: TextStyle(color: Colors.white, height: 1.45),
            ),
            const SizedBox(height: 16),
            Text(
              '$completed of $total completed',
              style: const TextStyle(color: Colors.white70),
            ),
            if (next != null) ...[
              const SizedBox(height: 14),
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFFFEB3B),
                  foregroundColor: const Color(0xFF111111),
                ),
                onPressed: () => onOpen(next!),
                icon: const Icon(Icons.play_arrow),
                label: Text(
                  completed == 0 ? 'Start learning path' : 'Continue learning',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FrameworkStrip extends StatelessWidget {
  const _FrameworkStrip();

  static const _steps = [
    ('1', 'Clarify', 'Scope, scale, offline'),
    ('2', 'Map', 'Client + server flow'),
    ('3', 'Model', 'Data, API, state'),
    ('4', 'Deep dive', 'Hardest 2–3 parts'),
    ('5', 'Defend', 'Failures, metrics, rollout'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final step in _steps) ...[
            Container(
              width: 148,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.$1,
                    style: const TextStyle(
                      color: Color(0xFF0B6E4F),
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    step.$2,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 3),
                  Text(step.$3, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

String _categoryFor(String id) {
  if ({
    'on-device-llm-ai-engine',
    'how-ai-summarization-agents-work',
    'history-of-agentic-loops',
  }.contains(id)) {
    return 'AI & ML';
  }
  if ({
    'video-streaming-player',
    'video-feed-streaming',
    'spotify-audio-player',
  }.contains(id)) {
    return 'Media';
  }
  if ({
    'messaging-chat',
    'collaborative-editor',
    'slack-channel-sync',
    'google-meet-webrtc',
  }.contains(id)) {
    return 'Realtime';
  }
  if ({
    'payment-checkout',
    'e-commerce-catalog',
    'airbnb-search-booking',
    'sdui-engine',
  }.contains(id)) {
    return 'Product systems';
  }
  if ({
    'authentication-oauth-biometric',
    'mobile-security-privacy-engine',
    'deep-linking-universal-links',
  }.contains(id)) {
    return 'Security';
  }
  if ({
    'social-feed',
    'realtime-location-tracking',
    'doordash-delivery-tracker',
    'google-calendar',
    'search-autocomplete',
  }.contains(id)) {
    return 'App architecture';
  }
  if ({
    'cheatsheet',
    'generic-mobile-problems',
    'mobile-platform-engineering-em',
  }.contains(id)) {
    return 'Start here';
  }
  return 'Platform & SDKs';
}

IconData _iconFor(String id) {
  return switch (_categoryFor(id)) {
    'AI & ML' => Icons.auto_awesome_outlined,
    'Media' => Icons.play_circle_outline,
    'Realtime' => Icons.forum_outlined,
    'Product systems' => Icons.shopping_bag_outlined,
    'Security' => Icons.shield_outlined,
    'App architecture' => Icons.account_tree_outlined,
    'Start here' => Icons.school_outlined,
    _ => Icons.build_outlined,
  };
}
