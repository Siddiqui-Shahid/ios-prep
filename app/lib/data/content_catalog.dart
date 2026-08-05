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

  Future<String> loadMarkdown(ChapterRef chapter) {
    return rootBundle.loadString(chapter.markdownAsset);
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
        // Skip blockquote intro lines that are not part of a section
        body.writeln(line);
      }
    }
    flush();

    if (sections.isEmpty) {
      // Fallback: treat whole file as one section
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
