import 'package:flutter/material.dart';

import '../services/tts_player_service.dart';
import 'sectioned_markdown.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({
    super.key,
    required this.player,
    required this.onBookmark,
    required this.onOpenSpeed,
    required this.onAccentChanged,
  });

  final TtsPlayerService player;
  final VoidCallback onBookmark;
  final VoidCallback onOpenSpeed;
  final ValueChanged<VoiceAccent> onAccentChanged;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: player,
      builder: (context, _) {
        final section = player.currentSection;
        final total = player.sections.length;
        final index = total == 0 ? 0 : player.sectionIndex + 1;
        final speedLabel = '${_formatSpeed(player.speed)}x';

        return Material(
          elevation: 8,
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    section == null
                        ? 'No section'
                        : 'Section $index / $total — ${section.title}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: kActiveInk,
                        ),
                  ),
                  const SizedBox(height: 6),
                  // Transport controls — one compact row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _Ctrl(
                        tooltip: 'Previous section',
                        icon: Icons.skip_previous,
                        onPressed: player.sections.isEmpty
                            ? null
                            : () => player.skipToPrevious(),
                      ),
                      _Ctrl(
                        tooltip: 'Back 5 seconds',
                        icon: Icons.replay_5,
                        onPressed: player.sections.isEmpty
                            ? null
                            : () => player.seekBySeconds(-5),
                      ),
                      IconButton.filled(
                        tooltip: player.isPlaying ? 'Pause' : 'Play',
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF0B6E4F),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(52, 52),
                        ),
                        onPressed: player.sections.isEmpty
                            ? null
                            : () => player.toggle(),
                        icon: Icon(
                          player.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 28,
                        ),
                      ),
                      _Ctrl(
                        tooltip: 'Forward 5 seconds',
                        icon: Icons.forward_5,
                        onPressed: player.sections.isEmpty
                            ? null
                            : () => player.seekBySeconds(5),
                      ),
                      _Ctrl(
                        tooltip: 'Next section',
                        icon: Icons.skip_next,
                        onPressed: player.sections.isEmpty
                            ? null
                            : () => player.skipToNext(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Speed / accent / bookmark — second row, never overflows
                  Row(
                    children: [
                      Expanded(
                        child: SegmentedButton<VoiceAccent>(
                          style: ButtonStyle(
                            visualDensity: VisualDensity.compact,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return kActiveInk;
                              }
                              return null;
                            }),
                            backgroundColor:
                                WidgetStateProperty.resolveWith((states) {
                              if (states.contains(WidgetState.selected)) {
                                return kActiveHighlight;
                              }
                              return null;
                            }),
                          ),
                          segments: const [
                            ButtonSegment(
                              value: VoiceAccent.us,
                              label: Text('US'),
                              tooltip: 'American English',
                            ),
                            ButtonSegment(
                              value: VoiceAccent.gb,
                              label: Text('UK'),
                              tooltip: 'British English',
                            ),
                          ],
                          selected: {player.accent},
                          onSelectionChanged: (set) {
                            if (set.isNotEmpty) onAccentChanged(set.first);
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      Material(
                        color: kActiveHighlight,
                        borderRadius: BorderRadius.circular(20),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: onOpenSpeed,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.speed,
                                  size: 18,
                                  color: kActiveInk,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  speedLabel,
                                  key: ValueKey(speedLabel),
                                  style: const TextStyle(
                                    color: kActiveInk,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        tooltip: 'Bookmark here',
                        onPressed: onBookmark,
                        icon: const Icon(Icons.bookmark_add_outlined),
                      ),
                    ],
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

class _Ctrl extends StatelessWidget {
  const _Ctrl({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      visualDensity: VisualDensity.compact,
      onPressed: onPressed,
      icon: Icon(icon),
    );
  }
}

Future<void> showSpeedSheet({
  required BuildContext context,
  required TtsPlayerService player,
  required ValueChanged<double> onChanged,
  ValueChanged<double>? onCommit,
}) async {
  var local = _clampSpeed(player.speed);
  final controller = TextEditingController(text: _formatSpeed(local));
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setModal) {
          void syncField(double speed) {
            controller.text = _formatSpeed(speed);
            controller.selection = TextSelection.collapsed(
              offset: controller.text.length,
            );
          }

          void preview(double raw) {
            final next = _clampSpeed(raw);
            setModal(() => local = next);
            syncField(next);
            onChanged(next);
          }

          void commit(double raw) {
            final next = _clampSpeed(raw);
            setModal(() => local = next);
            syncField(next);
            (onCommit ?? onChanged)(next);
          }

          void commitTyped() {
            final parsed = double.tryParse(
              controller.text.trim().replaceAll(RegExp(r'[xX]'), ''),
            );
            if (parsed == null) {
              syncField(local);
              return;
            }
            commit(parsed);
          }

          return SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 8,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Playback speed',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '0.5x–16x. Type any value, or use presets. Higher speeds speak faster, shorten gaps, and soften comma/period pauses.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: kActiveHighlight,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: kActiveInk, width: 1.2),
                      ),
                      child: Text(
                        '${_formatSpeed(local)}x',
                        key: ValueKey('sheet-speed-$local'),
                        style: const TextStyle(
                          color: kActiveInk,
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: controller,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      labelText: 'Custom speed',
                      hintText: 'e.g. 10 or 12.5',
                      suffixText: 'x',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => commitTyped(),
                    onEditingComplete: commitTyped,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: commitTyped,
                      child: const Text('Apply'),
                    ),
                  ),
                  Slider(
                    min: 0.5,
                    max: 16.0,
                    divisions: 31,
                    activeColor: const Color(0xFF0B6E4F),
                    value: local,
                    label: '${_formatSpeed(local)}x',
                    onChanged: preview,
                    onChangeEnd: commit,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      0.5,
                      1.0,
                      1.5,
                      2.0,
                      3.0,
                      4.0,
                      6.0,
                      8.0,
                      12.0,
                      16.0,
                    ].map((s) {
                      final selected = (local - s).abs() < 0.01;
                      return ActionChip(
                        label: Text('${_formatSpeed(s)}x'),
                        backgroundColor:
                            selected ? kActiveHighlight : Colors.black12,
                        labelStyle: TextStyle(
                          color: kActiveInk,
                          fontWeight:
                              selected ? FontWeight.w800 : FontWeight.w500,
                        ),
                        side: selected
                            ? const BorderSide(color: kActiveInk, width: 1.2)
                            : BorderSide.none,
                        onPressed: () => commit(s),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ).whenComplete(controller.dispose);
}

String _formatSpeed(double value) {
  if ((value - value.roundToDouble()).abs() < 0.01) {
    return value.round().toString();
  }
  return value.toStringAsFixed(1);
}

double _clampSpeed(double value) => value.clamp(0.5, 16.0);
