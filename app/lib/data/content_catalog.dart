import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/models.dart';

class ContentCatalog {
  ContentCatalog._(this.manifest);

  final ContentManifest manifest;

  static Future<ContentCatalog> load() async {
    final raw = await rootBundle.loadString('assets/content/manifest.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return ContentCatalog._(ContentManifest.fromJson(json));
  }

  WeekRef get week1 =>
      manifest.weekById('week-01') ??
      (throw StateError('week-01 missing from manifest'));

  List<WeekRef> get weeks => manifest.weeks;

  List<WeekRef> get revisionWeeks => manifest.revisionWeeks;

  List<WeekRef> get flashcardWeeks => manifest.flashcardWeeks;

  Future<String> loadMarkdown(ChapterRef chapter) {
    return rootBundle.loadString(chapter.markdownAsset);
  }

  Future<String> loadCodeSource(CodeFileRef file) {
    return rootBundle.loadString(file.asset);
  }

  /// Chapter markdown plus inlined lesson code so readers see demos without leaving.
  Future<String> loadMarkdownWithEmbeddedCode(
    ChapterRef chapter,
    DayRef day,
  ) async {
    final md = await loadMarkdown(chapter);
    if (day.codeFiles.isEmpty) return md;

    final referenced = <CodeFileRef>[];
    final seen = <String>{};
    for (final match in RegExp(r'\[[^\]]*\]\(([^)]+)\)').allMatches(md)) {
      final file = codeFileForLink(day, match.group(1)!);
      if (file == null || !seen.add(file.id)) continue;
      referenced.add(file);
    }

    final files = referenced.isNotEmpty
        ? referenced
        : (day.codeFiles.length <= 4 ? day.codeFiles : const <CodeFileRef>[]);

    final buf = StringBuffer(md.trimRight());
    buf.writeln('\n\n---\n');
    buf.writeln('## Lesson code\n');

    if (files.isEmpty) {
      buf.writeln(
        'This day has **${day.codeFiles.length}** code files. '
        'Open **Code** in the reader toolbar to browse them.\n',
      );
      for (final file in day.codeFiles) {
        buf.writeln('- `${file.title}`');
      }
      buf.writeln();
      return buf.toString();
    }

    for (final file in files) {
      try {
        final src = await loadCodeSource(file);
        final fence = file.language == 'markdown' ? 'markdown' : file.language;
        buf.writeln('### `${file.title}`\n');
        buf.writeln('```$fence');
        buf.writeln(src.trimRight());
        buf.writeln('```\n');
      } catch (_) {
        buf.writeln('### `${file.title}`\n');
        buf.writeln('_File missing from the app bundle._\n');
      }
    }
    return buf.toString();
  }

  Future<List<ScriptSection>> loadScriptSections(ChapterRef chapter) async {
    final raw = await rootBundle.loadString(chapter.scriptAsset);
    return parseScriptSections(raw);
  }

  static List<ScriptSection> parseScriptSections(String markdown) {
    final lines = markdown.split('\n');
    final sections = <ScriptSection>[];
    String? currentId;
    String? currentTitle;
    final body = StringBuffer();
    var index = 0;

    void flush() {
      if (currentId == null || currentTitle == null) return;
      final text = body.toString().trim();
      if (text.isEmpty) return;
      sections.add(
        ScriptSection(
          index: index++,
          id: currentId,
          title: currentTitle,
          body: text,
        ),
      );
      body.clear();
    }

    final heading = RegExp(r'^##\s+§(\d+)\s+(.+)$');
    for (final line in lines) {
      final match = heading.firstMatch(line);
      if (match != null) {
        flush();
        currentId = '§${match.group(1)}';
        currentTitle = match.group(2)!.trim();
        continue;
      }
      if (currentId != null) {
        body.writeln(line);
      }
    }
    flush();

    if (sections.isEmpty) {
      final cleaned = markdown
          .replaceFirst(RegExp(r'^#.*$', multiLine: true), '')
          .trim();
      return [
        ScriptSection(
          index: 0,
          id: '§0',
          title: 'Full chapter',
          body: cleaned.isEmpty ? 'No script available.' : cleaned,
        ),
      ];
    }
    return sections;
  }
}
