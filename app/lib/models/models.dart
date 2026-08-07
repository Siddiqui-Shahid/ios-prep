class ChapterRef {
  const ChapterRef({
    required this.id,
    required this.title,
    required this.markdownAsset,
    required this.scriptAsset,
  });

  final String id;
  final String title;
  final String markdownAsset;
  final String scriptAsset;

  factory ChapterRef.fromJson(Map<String, dynamic> json) {
    return ChapterRef(
      id: json['id'] as String,
      title: json['title'] as String,
      markdownAsset: json['markdown'] as String,
      scriptAsset: json['script'] as String,
    );
  }
}

class CodeFileRef {
  const CodeFileRef({
    required this.id,
    required this.title,
    required this.asset,
    this.language = 'text',
  });

  final String id;
  final String title;
  final String asset;
  final String language;

  factory CodeFileRef.fromJson(Map<String, dynamic> json) {
    return CodeFileRef(
      id: json['id'] as String,
      title: json['title'] as String,
      asset: json['asset'] as String,
      language: json['language'] as String? ?? 'text',
    );
  }
}

class DayRef {
  const DayRef({
    required this.id,
    required this.title,
    required this.chapters,
    this.codeFiles = const [],
  });

  final String id;
  final String title;
  final List<ChapterRef> chapters;
  final List<CodeFileRef> codeFiles;

  factory DayRef.fromJson(Map<String, dynamic> json) {
    return DayRef(
      id: json['id'] as String,
      title: json['title'] as String,
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => ChapterRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      codeFiles: (json['code'] as List<dynamic>? ?? const [])
          .map((e) => CodeFileRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// Resolve `../code/Foo.swift` style links against the day's code files.
CodeFileRef? codeFileForLink(DayRef day, String href) {
  final cleaned = href.split('#').first.replaceAll('\\', '/').trim();
  final name = cleaned.split('/').last;
  if (name.isEmpty) return null;
  for (final file in day.codeFiles) {
    if (file.id == name || file.title == name) return file;
  }
  return null;
}

class WeekRef {
  const WeekRef({
    required this.id,
    required this.title,
    required this.days,
  });

  final String id;
  final String title;
  final List<DayRef> days;

  factory WeekRef.fromJson(Map<String, dynamic> json) {
    return WeekRef(
      id: json['id'] as String,
      title: json['title'] as String,
      days: (json['days'] as List<dynamic>)
          .map((e) => DayRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class ContentManifest {
  const ContentManifest({
    required this.weeks,
    this.revisionWeeks = const [],
    this.flashcardWeeks = const [],
  });

  final List<WeekRef> weeks;
  final List<WeekRef> revisionWeeks;
  final List<WeekRef> flashcardWeeks;

  factory ContentManifest.fromJson(Map<String, dynamic> json) {
    return ContentManifest(
      weeks: (json['weeks'] as List<dynamic>)
          .map((e) => WeekRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      revisionWeeks: (json['revisionWeeks'] as List<dynamic>? ?? const [])
          .map((e) => WeekRef.fromJson(e as Map<String, dynamic>))
          .toList(),
      flashcardWeeks: (json['flashcardWeeks'] as List<dynamic>? ?? const [])
          .map((e) => WeekRef.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Iterable<WeekRef> get allTracks sync* {
    yield* weeks;
    yield* revisionWeeks;
    yield* flashcardWeeks;
  }

  WeekRef? weekById(String id) {
    for (final w in allTracks) {
      if (w.id == id) return w;
    }
    return null;
  }

  ChapterLocation? findChapter(String weekId, String dayId, String chapterId) {
    final week = weekById(weekId);
    if (week == null) return null;
    for (final day in week.days) {
      if (day.id != dayId) continue;
      for (final chapter in day.chapters) {
        if (chapter.id == chapterId) {
          return ChapterLocation(week: week, day: day, chapter: chapter);
        }
      }
    }
    return null;
  }
}

class ChapterLocation {
  const ChapterLocation({
    required this.week,
    required this.day,
    required this.chapter,
  });

  final WeekRef week;
  final DayRef day;
  final ChapterRef chapter;
}

class ScriptSection {
  const ScriptSection({
    required this.index,
    required this.id,
    required this.title,
    required this.body,
  });

  final int index;
  final String id;
  final String title;
  final String body;
}

class Bookmark {
  const Bookmark({
    required this.weekId,
    required this.dayId,
    required this.chapterId,
    required this.sectionIndex,
    required this.updatedAt,
    this.chapterTitle = '',
    this.dayTitle = '',
  });

  final String weekId;
  final String dayId;
  final String chapterId;
  final int sectionIndex;
  final DateTime updatedAt;
  final String chapterTitle;
  final String dayTitle;

  Map<String, dynamic> toJson() => {
        'weekId': weekId,
        'dayId': dayId,
        'chapterId': chapterId,
        'sectionIndex': sectionIndex,
        'updatedAt': updatedAt.toIso8601String(),
        'chapterTitle': chapterTitle,
        'dayTitle': dayTitle,
      };

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      weekId: json['weekId'] as String,
      dayId: json['dayId'] as String,
      chapterId: json['chapterId'] as String,
      sectionIndex: json['sectionIndex'] as int? ?? 0,
      updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? '') ??
          DateTime.now(),
      chapterTitle: json['chapterTitle'] as String? ?? '',
      dayTitle: json['dayTitle'] as String? ?? '',
    );
  }
}

enum ReminderRepeat { once, daily, weekdays }

class StudyReminder {
  const StudyReminder({
    required this.id,
    required this.label,
    required this.hour,
    required this.minute,
    required this.repeat,
    required this.enabled,
  });

  final String id;
  final String label;
  final int hour;
  final int minute;
  final ReminderRepeat repeat;
  final bool enabled;

  StudyReminder copyWith({
    String? id,
    String? label,
    int? hour,
    int? minute,
    ReminderRepeat? repeat,
    bool? enabled,
  }) {
    return StudyReminder(
      id: id ?? this.id,
      label: label ?? this.label,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      repeat: repeat ?? this.repeat,
      enabled: enabled ?? this.enabled,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'label': label,
        'hour': hour,
        'minute': minute,
        'repeat': repeat.name,
        'enabled': enabled,
      };

  factory StudyReminder.fromJson(Map<String, dynamic> json) {
    return StudyReminder(
      id: json['id'] as String,
      label: json['label'] as String,
      hour: json['hour'] as int,
      minute: json['minute'] as int,
      repeat: ReminderRepeat.values.firstWhere(
        (e) => e.name == json['repeat'],
        orElse: () => ReminderRepeat.daily,
      ),
      enabled: json['enabled'] as bool? ?? true,
    );
  }
}
