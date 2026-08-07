import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../models/models.dart';
import '../widgets/sectioned_markdown.dart';

class CodeLabScreen extends StatefulWidget {
  const CodeLabScreen({
    super.key,
    required this.day,
    this.initialFileId,
  });

  final DayRef day;
  final String? initialFileId;

  @override
  State<CodeLabScreen> createState() => _CodeLabScreenState();
}

class _CodeLabScreenState extends State<CodeLabScreen> {
  late CodeFileRef _selected;
  String? _source;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    final files = widget.day.codeFiles;
    _selected = files.firstWhere(
      (f) => f.id == widget.initialFileId,
      orElse: () => files.first,
    );
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final raw = await rootBundle.loadString(_selected.asset);
      if (!mounted) return;
      setState(() {
        _source = raw;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Could not load ${_selected.title}';
        _source = null;
        _loading = false;
      });
    }
  }

  Future<void> _select(CodeFileRef file) async {
    if (file.id == _selected.id) return;
    setState(() => _selected = file);
    await _load();
  }

  Future<void> _copy() async {
    final text = _source;
    if (text == null) return;
    await Clipboard.setData(ClipboardData(text: text));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied ${_selected.title}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final files = widget.day.codeFiles;
    final scheme = Theme.of(context).colorScheme;
    final isMarkdown = _selected.language == 'markdown';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson code'),
        actions: [
          IconButton(
            tooltip: 'Copy file',
            onPressed: _source == null ? null : _copy,
            icon: const Icon(Icons.copy_outlined),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 52,
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
              scrollDirection: Axis.horizontal,
              itemCount: files.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final file = files[index];
                final selected = file.id == _selected.id;
                return ChoiceChip(
                  label: Text(file.title),
                  selected: selected,
                  selectedColor: kActiveHighlight,
                  labelStyle: TextStyle(
                    color: selected ? kActiveInk : null,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                  onSelected: (_) => _select(file),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(child: Text(_error!))
                    : isMarkdown
                        ? Markdown(
                            data: _source ?? '',
                            selectable: true,
                            padding: const EdgeInsets.all(16),
                          )
                        : Container(
                            color: scheme.surfaceContainerLowest,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: SelectableText(
                                _source ?? '',
                                style: TextStyle(
                                  fontFamily: 'Menlo',
                                  fontFamilyFallback: const [
                                    'Courier',
                                    'monospace',
                                  ],
                                  fontSize: 13.5,
                                  height: 1.45,
                                  color: scheme.onSurface,
                                ),
                              ),
                            ),
                          ),
          ),
        ],
      ),
    );
  }
}

/// Opens a full-screen code browser for [day].
Future<void> openCodeLab(
  BuildContext context, {
  required DayRef day,
  String? initialFileId,
}) {
  return Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => CodeLabScreen(
        day: day,
        initialFileId: initialFileId,
      ),
    ),
  );
}
