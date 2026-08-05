import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:uuid/uuid.dart';

import '../models/models.dart';

class ReminderStore extends ChangeNotifier {
  ReminderStore(this._prefs, this._notifications);

  final SharedPreferences _prefs;
  final FlutterLocalNotificationsPlugin _notifications;
  static const _key = 'reminders';
  static const _uuid = Uuid();

  List<StudyReminder> get reminders {
    final raw = _prefs.getString(_key);
    if (raw == null) return const [];
    try {
      final list = jsonDecode(raw) as List<dynamic>;
      return list
          .map((e) => StudyReminder.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return const [];
    }
  }

  Future<void> _persist(List<StudyReminder> items) async {
    await _prefs.setString(
      _key,
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
    notifyListeners();
  }

  Future<StudyReminder> add({
    required String label,
    required int hour,
    required int minute,
    required ReminderRepeat repeat,
  }) async {
    final reminder = StudyReminder(
      id: _uuid.v4(),
      label: label,
      hour: hour,
      minute: minute,
      repeat: repeat,
      enabled: true,
    );
    final next = [...reminders, reminder];
    await _persist(next);
    await _schedule(reminder);
    return reminder;
  }

  Future<void> update(StudyReminder reminder) async {
    final next =
        reminders.map((r) => r.id == reminder.id ? reminder : r).toList();
    await _persist(next);
    await _notifications.cancel(id: reminder.id.hashCode);
    if (reminder.enabled) {
      await _schedule(reminder);
    }
  }

  Future<void> delete(String id) async {
    await _notifications.cancel(id: id.hashCode);
    await _persist(reminders.where((r) => r.id != id).toList());
  }

  Future<void> rescheduleAll() async {
    for (final r in reminders) {
      await _notifications.cancel(id: r.id.hashCode);
      if (r.enabled) await _schedule(r);
    }
  }

  Future<void> _schedule(StudyReminder reminder) async {
    const android = AndroidNotificationDetails(
      'study_reminders',
      'Study reminders',
      channelDescription: 'iOS interview prep study reminders',
      importance: Importance.high,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails();
    const details = NotificationDetails(android: android, iOS: ios);

    final when = _nextInstance(reminder.hour, reminder.minute);
    final mode = switch (reminder.repeat) {
      ReminderRepeat.once => null,
      ReminderRepeat.daily => DateTimeComponents.time,
      ReminderRepeat.weekdays => DateTimeComponents.dayOfWeekAndTime,
    };

    await _notifications.zonedSchedule(
      id: reminder.id.hashCode,
      title: reminder.label,
      body: reminder.repeat == ReminderRepeat.weekdays
          ? 'Weekday study time — open iOS Prep Audiobook'
          : 'Time to continue your iOS interview prep',
      scheduledDate: when,
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: mode,
    );
  }

  tz.TZDateTime _nextInstance(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
