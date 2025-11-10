import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:taska/core/utils/functions/extensions.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static Future init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification_icon');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveBackgroundNotificationResponse: (details) {},
    );
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
    );
  }

  static void scheduleNotifications({
    required String id,
    String? title,
    String? body,
    required DateTime scheduledDate,
  }) async {
    _flutterLocalNotificationsPlugin.zonedSchedule(
      id.generateId(),
      title,
      body,

      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }

  static void cancelNotification(String id) async {
    await _flutterLocalNotificationsPlugin.cancel(id.generateId());
  }

  static void cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
