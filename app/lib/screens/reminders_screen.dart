import 'package:flutter/material.dart';

import '../data/reminder_store.dart';
import '../models/models.dart';

class RemindersScreen extends StatelessWidget {
  const RemindersScreen({super.key, required this.store});

  final ReminderStore store;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final items = store.reminders;
        return Scaffold(
          appBar: AppBar(title: const Text('Study reminders')),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _openEditor(context),
            icon: const Icon(Icons.add_alarm),
            label: const Text('Add'),
          ),
          body: items.isEmpty
              ? const Center(
                  child: Text('No reminders yet. Add one to study offline on a schedule.'),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final r = items[index];
                    final time =
                        '${r.hour.toString().padLeft(2, '0')}:${r.minute.toString().padLeft(2, '0')}';
                    return Card(
                      child: ListTile(
                        leading: Icon(
                          r.enabled ? Icons.alarm_on : Icons.alarm_off,
                        ),
                        title: Text(r.label),
                        subtitle: Text('$time · ${r.repeat.name}'),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) async {
                            switch (value) {
                              case 'edit':
                                await _openEditor(context, existing: r);
                              case 'toggle':
                                await store.update(
                                  r.copyWith(enabled: !r.enabled),
                                );
                              case 'delete':
                                await store.delete(r.id);
                            }
                          },
                          itemBuilder: (_) => const [
                            PopupMenuItem(value: 'edit', child: Text('Edit')),
                            PopupMenuItem(
                              value: 'toggle',
                              child: Text('Enable / disable'),
                            ),
                            PopupMenuItem(
                              value: 'delete',
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Future<void> _openEditor(
    BuildContext context, {
    StudyReminder? existing,
  }) async {
    final labelCtrl = TextEditingController(
      text: existing?.label ?? 'Evening study',
    );
    var time = TimeOfDay(
      hour: existing?.hour ?? 20,
      minute: existing?.minute ?? 0,
    );
    var repeat = existing?.repeat ?? ReminderRepeat.daily;

    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModal) {
            return Padding(
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
                    existing == null ? 'Add reminder' : 'Edit reminder',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: labelCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Label',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Time'),
                    subtitle: Text(time.format(context)),
                    trailing: const Icon(Icons.schedule),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      if (picked != null) setModal(() => time = picked);
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<ReminderRepeat>(
                    initialValue: repeat,
                    decoration: const InputDecoration(
                      labelText: 'Repeat',
                      border: OutlineInputBorder(),
                    ),
                    items: ReminderRepeat.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e.name),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      if (v != null) setModal(() => repeat = v);
                    },
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('Save'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (saved != true) return;
    final label = labelCtrl.text.trim().isEmpty
        ? 'Study reminder'
        : labelCtrl.text.trim();
    if (existing == null) {
      await store.add(
        label: label,
        hour: time.hour,
        minute: time.minute,
        repeat: repeat,
      );
    } else {
      await store.update(
        existing.copyWith(
          label: label,
          hour: time.hour,
          minute: time.minute,
          repeat: repeat,
        ),
      );
    }
  }
}
