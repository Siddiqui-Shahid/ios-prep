import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const kActiveHighlight = Color(0xFFFFEB3B);
const kActiveInk = Color(0xFF111111);

class MarkdownSection {
  const MarkdownSection({required this.heading, required this.body});

  final String heading;
  final String body;
}

List<MarkdownSection> splitMarkdownSections(String markdown) {
  final lines = markdown.split('\n');
  final sections = <MarkdownSection>[];
  var heading = 'Introduction';
  final buf = StringBuffer();

  void flush() {
    final body = buf.toString().trimRight();
    if (body.trim().isEmpty && sections.isNotEmpty) {
      buf.clear();
      return;
    }
    sections.add(MarkdownSection(heading: heading, body: body));
    buf.clear();
  }

  var sawContent = false;
  for (final line in lines) {
    if (line.startsWith('# ') && !sawContent) {
      sawContent = true;
      buf.writeln(line);
      continue;
    }
    sawContent = true;
    if (line.startsWith('## ') ||
        RegExp(r'^###\s+Q\d+\.').hasMatch(line)) {
      flush();
      heading = line.replaceFirst(RegExp(r'^#{2,3}\s+'), '').trim();
      buf.writeln(line);
    } else {
      buf.writeln(line);
    }
  }
  flush();
  if (sections.isEmpty) {
    return [MarkdownSection(heading: 'Chapter', body: markdown)];
  }
  return sections;
}

int matchSectionIndex({
  required List<MarkdownSection> markdownSections,
  required String scriptTitle,
  required int scriptIndex,
}) {
  final needle = scriptTitle
      .toLowerCase()
      .replaceAll(RegExp(r'^[\d.]+\s*'), '')
      .trim();
  for (var i = 0; i < markdownSections.length; i++) {
    final h = markdownSections[i].heading.toLowerCase();
    final plain = h.replaceAll(RegExp(r'^[\d.]+\s*'), '').trim();
    if (h.contains(needle) || needle.contains(plain)) {
      return i;
    }
  }
  return scriptIndex.clamp(0, markdownSections.length - 1);
}

class SectionedMarkdownReader extends StatefulWidget {
  const SectionedMarkdownReader({
    super.key,
    required this.markdown,
    required this.activeScriptTitle,
    required this.activeScriptIndex,
    this.highlightActive = true,
  });

  final String markdown;
  final String activeScriptTitle;
  final int activeScriptIndex;
  final bool highlightActive;

  @override
  State<SectionedMarkdownReader> createState() =>
      _SectionedMarkdownReaderState();
}

class _SectionedMarkdownReaderState extends State<SectionedMarkdownReader> {
  late List<MarkdownSection> _sections;
  final _keys = <GlobalKey>[];

  @override
  void initState() {
    super.initState();
    _rebuild();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToActive());
  }

  @override
  void didUpdateWidget(covariant SectionedMarkdownReader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.markdown != widget.markdown) {
      _rebuild();
    }
    if (oldWidget.activeScriptIndex != widget.activeScriptIndex ||
        oldWidget.activeScriptTitle != widget.activeScriptTitle) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToActive());
    }
  }

  void _rebuild() {
    _sections = splitMarkdownSections(widget.markdown);
    _keys
      ..clear()
      ..addAll(List.generate(_sections.length, (_) => GlobalKey()));
  }

  void _scrollToActive() {
    if (!widget.highlightActive || _keys.isEmpty) return;
    final idx = matchSectionIndex(
      markdownSections: _sections,
      scriptTitle: widget.activeScriptTitle,
      scriptIndex: widget.activeScriptIndex,
    );
    final ctx = _keys[idx].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
        alignment: 0.1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final activeIdx = widget.highlightActive
        ? matchSectionIndex(
            markdownSections: _sections,
            scriptTitle: widget.activeScriptTitle,
            scriptIndex: widget.activeScriptIndex,
          )
        : -1;

    final inactiveInk = scheme.onSurface;
    final inactiveMuted = scheme.onSurfaceVariant;
    final inactiveCodeBg = scheme.surfaceContainerHighest;

    final baseSheet = MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
      h1: textTheme.headlineSmall?.copyWith(color: inactiveInk),
      h2: textTheme.titleLarge?.copyWith(color: inactiveInk),
      h3: textTheme.titleMedium?.copyWith(color: inactiveInk),
      p: textTheme.bodyLarge?.copyWith(height: 1.45, color: inactiveInk),
      listBullet: TextStyle(color: inactiveInk),
      a: TextStyle(
        color: scheme.primary,
        decoration: TextDecoration.underline,
      ),
      code: TextStyle(
        backgroundColor: inactiveCodeBg,
        color: inactiveInk,
      ),
      codeblockDecoration: BoxDecoration(
        color: inactiveCodeBg,
        borderRadius: BorderRadius.circular(8),
      ),
      blockquoteDecoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        border: Border(left: BorderSide(color: inactiveMuted, width: 3)),
      ),
      blockquote: textTheme.bodyLarge?.copyWith(color: inactiveMuted),
      tableHead: textTheme.titleSmall?.copyWith(color: inactiveInk),
      tableBody: textTheme.bodyMedium?.copyWith(color: inactiveInk),
    );

    // On the yellow active panel, use near-black ink + ~10% black fills so
    // blockquotes/code stay readable (theme surface colors are fully dark).
    const activeWash = Color(0x1A000000); // black @ 10% opacity
    final activeSheet = baseSheet.copyWith(
      h1: textTheme.headlineSmall?.copyWith(color: kActiveInk),
      h2: textTheme.titleLarge?.copyWith(color: kActiveInk),
      h3: textTheme.titleMedium?.copyWith(color: kActiveInk),
      p: textTheme.bodyLarge?.copyWith(height: 1.45, color: kActiveInk),
      listBullet: const TextStyle(color: kActiveInk),
      a: const TextStyle(
        color: kActiveInk,
        decoration: TextDecoration.underline,
      ),
      code: const TextStyle(
        backgroundColor: activeWash,
        color: kActiveInk,
      ),
      codeblockDecoration: BoxDecoration(
        color: activeWash,
        borderRadius: BorderRadius.circular(8),
      ),
      blockquoteDecoration: const BoxDecoration(
        color: activeWash,
        border: Border(
          left: BorderSide(color: Color(0x66000000), width: 3),
        ),
      ),
      blockquote: textTheme.bodyLarge?.copyWith(color: kActiveInk),
      tableHead: textTheme.titleSmall?.copyWith(color: kActiveInk),
      tableBody: textTheme.bodyMedium?.copyWith(color: kActiveInk),
      tableBorder: TableBorder.all(
        color: const Color(0x66000000),
        width: 0.8,
      ),
      tableCellsDecoration: const BoxDecoration(color: activeWash),
    );

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 24),
      itemCount: _sections.length,
      itemBuilder: (context, index) {
        final section = _sections[index];
        final active = index == activeIdx;
        return Container(
          key: _keys[index],
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: active ? kActiveHighlight : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: active ? Colors.black87 : scheme.outlineVariant,
              width: active ? 1.2 : 1,
            ),
          ),
          child: MarkdownBody(
            data: section.body.trim().isEmpty
                ? '## ${section.heading}'
                : section.body,
            selectable: true,
            styleSheet: active ? activeSheet : baseSheet,
          ),
        );
      },
    );
  }
}
