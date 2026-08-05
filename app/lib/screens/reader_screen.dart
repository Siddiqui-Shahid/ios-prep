import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/tts_player_service.dart';
import '../widgets/player_bar.dart';
import '../widgets/sectioned_markdown.dart';

enum ReaderMode { listen, read }

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({
    super.key,
    required this.week,
    required this.day,
    required this.chapter,
    required this.markdown,
    required this.sections,
    required this.player,
    required this.initialSection,
    required this.initialMode,
    required this.onBookmark,
    required this.onSpeedChanged,
    required this.onAccentChanged,
    required this.onModeChanged,
    required this.onSectionProgress,
    required this.onChapterCompleted,
  });

  final WeekRef week;
  final DayRef day;
  final ChapterRef chapter;
  final String markdown;
  final List<ScriptSection> sections;
  final TtsPlayerService player;
  final int initialSection;
  final ReaderMode initialMode;
  final Future<void> Function(int sectionIndex) onBookmark;
  final Future<void> Function(double speed) onSpeedChanged;
  final Future<void> Function(VoiceAccent accent) onAccentChanged;
  final Future<void> Function(ReaderMode mode) onModeChanged;
  final Future<void> Function(int sectionIndex) onSectionProgress;
  final Future<void> Function() onChapterCompleted;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late ReaderMode _mode;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    widget.player.onSectionChanged = () {
      widget.onSectionProgress(widget.player.sectionIndex);
      if (mounted) setState(() {});
    };
    widget.player.onChapterCompleted = () {
      widget.onChapterCompleted();
    };
    // Load sections into the player immediately so Play is enabled on first frame.
    // ignore: unawaited_futures
    _bootstrapPlayer();
  }

  Future<void> _bootstrapPlayer() async {
    await widget.player.loadChapter(
      title: widget.chapter.title,
      subtitle: '${widget.day.title} · ${widget.week.title}',
      sections: widget.sections,
      startSection: widget.initialSection,
      speed: widget.player.speed,
    );
    if (!mounted) return;
    if (_mode == ReaderMode.read) {
      await widget.player.pause();
    }
  }

  @override
  void dispose() {
    widget.player.onSectionChanged = null;
    widget.player.onChapterCompleted = null;
    super.dispose();
  }

  Future<void> _setMode(ReaderMode mode) async {
    if (_mode == mode) return;
    setState(() => _mode = mode);
    await widget.onModeChanged(mode);
    if (mode == ReaderMode.read) {
      await widget.player.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isListen = _mode == ReaderMode.listen;
    return ListenableBuilder(
      listenable: widget.player,
      builder: (context, _) {
        final active = widget.player.currentSection;
        final sentence = widget.player.currentSentence;
        final word = widget.player.currentWord;
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.chapter.title),
            actions: [
              IconButton(
                tooltip: 'Jump to section',
                onPressed: () => _showSectionPicker(context),
                icon: const Icon(Icons.list_alt),
              ),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                child: SizedBox(
                  width: double.infinity,
                  child: SegmentedButton<ReaderMode>(
                    style: ButtonStyle(
                      visualDensity: VisualDensity.compact,
                      backgroundColor: WidgetStateProperty.resolveWith((
                        states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return kActiveHighlight;
                        }
                        return null;
                      }),
                      foregroundColor: WidgetStateProperty.resolveWith((
                        states,
                      ) {
                        if (states.contains(WidgetState.selected)) {
                          return kActiveInk;
                        }
                        return null;
                      }),
                    ),
                    segments: const [
                      ButtonSegment(
                        value: ReaderMode.listen,
                        label: Text('Listen'),
                        icon: Icon(Icons.headphones, size: 18),
                      ),
                      ButtonSegment(
                        value: ReaderMode.read,
                        label: Text('Read'),
                        icon: Icon(Icons.menu_book, size: 18),
                      ),
                    ],
                    selected: {_mode},
                    onSelectionChanged: (set) {
                      if (set.isNotEmpty) _setMode(set.first);
                    },
                  ),
                ),
              ),
              if (isListen)
                Material(
                  color: kActiveHighlight,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(Icons.graphic_eq, color: kActiveInk),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                active == null
                                    ? 'Ready'
                                    : 'Now speaking: ${active.title}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: kActiveInk,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (sentence.isEmpty)
                                const Text(
                                  'Press play to listen. The audio explains everything in simple words.',
                                  style: TextStyle(color: kActiveInk),
                                )
                              else
                                _highlightedSentence(sentence, word),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                Material(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: const ListTile(
                    dense: true,
                    leading: Icon(Icons.menu_book),
                    title: Text('Read mode'),
                    subtitle: Text(
                      'Audio is off. Read the full chapter here.',
                    ),
                  ),
                ),
              Expanded(
                child: SectionedMarkdownReader(
                  markdown: widget.markdown,
                  activeScriptTitle: active?.title ?? '',
                  activeScriptIndex: widget.player.sectionIndex,
                  highlightActive: isListen,
                ),
              ),
              if (isListen)
                PlayerBar(
                  player: widget.player,
                  onBookmark: () async {
                    await widget.onBookmark(widget.player.sectionIndex);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Bookmark saved — resume from here anytime',
                          ),
                        ),
                      );
                    }
                  },
                  onOpenSpeed: () => showSpeedSheet(
                    context: context,
                    player: widget.player,
                    onChanged: (s) async {
                      await widget.player.setPlaybackRate(
                        s,
                        restartSpeech: false,
                      );
                      await widget.onSpeedChanged(s);
                    },
                    onCommit: (s) async {
                      await widget.player.setPlaybackRate(
                        s,
                        restartSpeech: true,
                      );
                      await widget.onSpeedChanged(s);
                    },
                  ),
                  onAccentChanged: (accent) async {
                    await widget.player.setAccent(accent);
                    await widget.onAccentChanged(accent);
                  },
                )
              else
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showSectionPicker(context),
                            icon: const Icon(Icons.list_alt),
                            label: const Text('Sections'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: FilledButton.icon(
                            style: FilledButton.styleFrom(
                              backgroundColor: const Color(0xFF0B6E4F),
                            ),
                            onPressed: () async {
                              await widget.onBookmark(
                                widget.player.sectionIndex,
                              );
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Bookmark saved'),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.bookmark_add_outlined),
                            label: const Text('Bookmark'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _highlightedSentence(String sentence, String word) {
    if (word.isEmpty) {
      return Text(
        sentence,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: kActiveInk),
      );
    }
    final lower = sentence.toLowerCase();
    final w = word.toLowerCase();
    final idx = lower.indexOf(w);
    if (idx < 0) {
      return Text(
        sentence,
        maxLines: 4,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: kActiveInk),
      );
    }
    final before = sentence.substring(0, idx);
    final match = sentence.substring(idx, idx + word.length);
    final after = sentence.substring(idx + word.length);
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(text: before, style: const TextStyle(color: kActiveInk)),
          TextSpan(
            text: match,
            style: const TextStyle(
              color: kActiveInk,
              backgroundColor: Color(0xFFFFC107),
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(text: after, style: const TextStyle(color: kActiveInk)),
        ],
      ),
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
    );
  }

  Future<void> _showSectionPicker(BuildContext context) async {
    final chosen = await showModalBottomSheet<int>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return ListTileTheme(
          selectedColor: kActiveInk,
          selectedTileColor: kActiveHighlight,
          child: ListView.builder(
            itemCount: widget.sections.length,
            itemBuilder: (context, i) {
              final s = widget.sections[i];
              final selected = i == widget.player.sectionIndex;
              return ListTile(
                selected: selected,
                selectedTileColor: kActiveHighlight,
                selectedColor: kActiveInk,
                iconColor: selected ? kActiveInk : null,
                textColor: selected ? kActiveInk : null,
                leading: Text(
                  s.id,
                  style: TextStyle(
                    color: selected ? kActiveInk : null,
                    fontWeight: selected ? FontWeight.w700 : null,
                  ),
                ),
                title: Text(s.title),
                onTap: () => Navigator.pop(context, i),
              );
            },
          ),
        );
      },
    );
    if (chosen != null) {
      await widget.player.jumpToSection(chosen);
      await widget.onSectionProgress(chosen);
      if (_mode == ReaderMode.read) {
        await widget.player.pause();
      }
    }
  }
}
