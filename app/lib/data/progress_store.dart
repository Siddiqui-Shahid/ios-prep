import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/models.dart';

class ProgressStore extends ChangeNotifier {
  ProgressStore(this._prefs);

  final SharedPreferences _prefs;

  static const _bookmarkKey = 'bookmark';
  static const _completedKey = 'completed_chapters';
  static const _sectionKeyPrefix = 'section_progress:';
  static const _speedKey = 'playback_speed';
  static const _accentKey = 'voice_accent';
  static const _readerModeKey = 'reader_mode';

  Bookmark? get bookmark {
    final raw = _prefs.getString(_bookmarkKey);
    if (raw == null) return null;
    try {
      return Bookmark.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }

  double get playbackSpeed => _prefs.getDouble(_speedKey) ?? 1.0;

  String get voiceAccent => _prefs.getString(_accentKey) ?? 'us';

  /// `listen` or `read`
  String get readerMode => _prefs.getString(_readerModeKey) ?? 'listen';

  Future<void> setPlaybackSpeed(double speed) async {
    await _prefs.setDouble(_speedKey, speed.clamp(0.5, 16.0));
    notifyListeners();
  }

  Future<void> setVoiceAccent(String accent) async {
    await _prefs.setString(_accentKey, accent);
    notifyListeners();
  }

  Future<void> setReaderMode(String mode) async {
    await _prefs.setString(_readerModeKey, mode == 'read' ? 'read' : 'listen');
    notifyListeners();
  }

  Set<String> get completedChapterKeys {
    final list = _prefs.getStringList(_completedKey) ?? const [];
    return list.toSet();
  }

  String chapterKey(String weekId, String dayId, String chapterId) =>
      '$weekId/$dayId/$chapterId';

  bool isChapterComplete(String weekId, String dayId, String chapterId) {
    return completedChapterKeys.contains(chapterKey(weekId, dayId, chapterId));
  }

  int sectionProgress(String weekId, String dayId, String chapterId) {
    return _prefs.getInt(
          '$_sectionKeyPrefix${chapterKey(weekId, dayId, chapterId)}',
        ) ??
        0;
  }

  Future<void> saveBookmark(Bookmark bookmark) async {
    await _prefs.setString(_bookmarkKey, jsonEncode(bookmark.toJson()));
    await _prefs.setInt(
      '$_sectionKeyPrefix${chapterKey(bookmark.weekId, bookmark.dayId, bookmark.chapterId)}',
      bookmark.sectionIndex,
    );
    notifyListeners();
  }

  Future<void> markChapterComplete(
    String weekId,
    String dayId,
    String chapterId,
  ) async {
    final keys = completedChapterKeys
      ..add(chapterKey(weekId, dayId, chapterId));
    await _prefs.setStringList(_completedKey, keys.toList());
    notifyListeners();
  }

  double dayProgress(DayRef day, String weekId) {
    if (day.chapters.isEmpty) return 0;
    var done = 0;
    for (final c in day.chapters) {
      if (isChapterComplete(weekId, day.id, c.id)) done++;
    }
    return done / day.chapters.length;
  }

  double weekProgress(WeekRef week) {
    final total = week.days.fold<int>(0, (n, d) => n + d.chapters.length);
    if (total == 0) return 0;
    var done = 0;
    for (final day in week.days) {
      for (final c in day.chapters) {
        if (isChapterComplete(week.id, day.id, c.id)) done++;
      }
    }
    return done / total;
  }
}
