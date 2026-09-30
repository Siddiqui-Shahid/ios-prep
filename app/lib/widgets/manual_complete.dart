import 'package:flutter/material.dart';

import '../data/progress_store.dart';

/// Persisted checkbox. Does not depend on auto "reached last section" progress.
class ManualCompleteButton extends StatelessWidget {
  const ManualCompleteButton({
    super.key,
    required this.progress,
    required this.id,
    this.label = 'Mark complete',
  });

  final ProgressStore progress;
  final String id;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        final done = progress.isManualComplete(id);
        return FilledButton.tonalIcon(
          style: FilledButton.styleFrom(
            backgroundColor: done
                ? Colors.white
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            foregroundColor: done ? Colors.black : null,
          ),
          onPressed: () async {
            await progress.toggleManualComplete(id);
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(done ? 'Marked incomplete' : 'Marked complete'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          icon: Icon(done ? Icons.check_circle : Icons.circle_outlined),
          label: Text(done ? 'Completed' : label),
        );
      },
    );
  }
}

class ManualCompleteIcon extends StatelessWidget {
  const ManualCompleteIcon({
    super.key,
    required this.progress,
    required this.id,
  });

  final ProgressStore progress;
  final String id;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: progress,
      builder: (context, _) {
        final done = progress.isManualComplete(id);
        return IconButton(
          tooltip: done ? 'Mark incomplete' : 'Mark complete',
          onPressed: () => progress.toggleManualComplete(id),
          icon: Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? Colors.white : null,
          ),
        );
      },
    );
  }
}
