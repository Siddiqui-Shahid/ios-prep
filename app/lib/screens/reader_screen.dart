import 'package:flutter/material.dart';

import '../models/models.dart';
import '../services/tts_player_service.dart';
import '../widgets/player_bar.dart';
import '../widgets/sectioned_markdown.dart';
import 'code_lab_screen.dart';

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
    this.spineIndex,
    this.spineLength = 0,
    this.previousTitle,
    this.nextTitle,
    this.onOpenPrevious,
    this.onOpenNext,
    required this.initialComplete,
    required this.onBookmark,
    required this.onSpeedChanged,
    required this.onAccentChanged,
    required this.onModeChanged,
    required this.onSectionProgress,
    required this.onChapterCompleted,
    required this.onSetComplete,
  });

  final WeekRef week;
  final DayRef day;
  final ChapterRef chapter;
  final String markdown;
  final List<ScriptSection> sections;
  final TtsPlayerService player;
  final int initialSection;
  final int? spineIndex;
  final int spineLength;
  final String? previousTitle;
  final String? nextTitle;
  final Future<void> Function()? onOpenPrevious;
  final Future<void> Function()? onOpenNext;
  final ReaderMode initialMode;
  final bool initialComplete;
  final Future<void> Function(int sectionIndex) onBookmark;
  final Future<void> Function(double speed) onSpeedChanged;
  final Future<void> Function(VoiceAccent accent) onAccentChanged;
  final Future<void> Function(ReaderMode mode) onModeChanged;
  final Future<void> Function(int sectionIndex) onSectionProgress;
  final Future<void> Function() onChapterCompleted;
  final Future<void> Function(bool complete) onSetComplete;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late ReaderMode _mode;
  late bool _complete;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
    _complete = widget.initialComplete;
    widget.player.onSectionChanged = () {
      widget.onSectionProgress(widget.player.sectionIndex);
      if (mounted) setState(() {});
    };
    widget.player.onChapterCompleted = () {
      widget.onChapterCompleted();
      if (mounted) setState(() => _complete = true);
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
          backgroundColor: const Color(0xFFF4EFE4),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF4EFE4),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.day.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.chapter.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            actions: [
              if (widget.spineIndex != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      '${widget.spineIndex! + 1} / ${widget.spineLength}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              IconButton(
                tooltip: _complete ? 'Mark as unread' : 'Mark as read',
                onPressed: _toggleComplete,
                icon: Icon(
                  _complete ? Icons.check_circle : Icons.check_circle_outline,
                  color: _complete ? const Color(0xFF0B6E4F) : null,
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) async {
                  if (value == 'listen' || value == 'read') {
                    await _setMode(
                      value == 'listen' ? ReaderMode.listen : ReaderMode.read,
                    );
                  } else if (value == 'sections') {
                    await _showSectionPicker(context);
                  } else if (value == 'code' &&
                      widget.day.codeFiles.isNotEmpty) {
                    if (!context.mounted) return;
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CodeLabScreen(day: widget.day),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: isListen ? 'read' : 'listen',
                    child: Text(isListen ? 'Read instead' : 'Listen'),
                  ),
                  const PopupMenuItem(
                    value: 'sections',
                    child: Text('Jump to section'),
                  ),
                  if (widget.day.codeFiles.isNotEmpty)
                    const PopupMenuItem(
                      value: 'code',
                      child: Text('Lesson code'),
                    ),
                ],
              ),
            ],
          ),
          body: Column(
            children: [
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
                ),
              Expanded(
                child: SectionedMarkdownReader(
                  markdown: widget.markdown,
                  activeScriptTitle: active?.title ?? '',
                  activeScriptIndex: widget.player.sectionIndex,
                  highlightActive: isListen,
                  onCodeLink: widget.day.codeFiles.isEmpty
                      ? null
                      : (href) {
                          final file = codeFileForLink(widget.day, href);
                          if (file == null) return false;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CodeLabScreen(
                                day: widget.day,
                                initialFileId: file.id,
                              ),
                            ),
                          );
                          return true;
                        },
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
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: widget.onOpenPrevious,
                                child: Text(
                                  widget.previousTitle == null
                                      ? 'Previous'
                                      : widget.previousTitle!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFF0B6E4F),
                                ),
                                onPressed: _toggleComplete,
                                child: Text(
                                  _complete ? 'Completed' : 'Mark complete',
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton.tonal(
                                onPressed: widget.onOpenNext,
                                child: Text(
                                  widget.nextTitle == null
                                      ? 'Next page'
                                      : widget.nextTitle!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
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

  Future<void> _setComplete(bool complete) async {
    await widget.onSetComplete(complete);
    if (!mounted) return;
    setState(() => _complete = complete);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(complete ? 'Marked as read' : 'Marked as unread'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Future<void> _toggleComplete() => _setComplete(!_complete);

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
          TextSpan(
            text: before,
            style: const TextStyle(color: kActiveInk),
          ),
          TextSpan(
            text: match,
            style: const TextStyle(
              color: kActiveInk,
              backgroundColor: Color(0xFFFFC107),
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: after,
            style: const TextStyle(color: kActiveInk),
          ),
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
        // Manual read-through: reaching the last section counts as read.
        if (widget.sections.isNotEmpty &&
            chosen >= widget.sections.length - 1 &&
            !_complete) {
          await _setComplete(true);
        }
      }
    }
  }
}
