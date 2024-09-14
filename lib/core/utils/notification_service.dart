import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notification = FlutterLocalNotificationsPlugin();

  static init() {
    _notification
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
    _notification.initialize(const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/tr_icon'),
      iOS: DarwinInitializationSettings(),
    ));
    tz.initializeTimeZones();
  }

  static scheduledNotification(
      String title, String body, int? dateTimeInSecends, int alarmID) async {
    const sound = 'rington.wav';
    var androidDetails = AndroidNotificationDetails(
      'important_notifications',
      'my channel',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      enableVibration: true,
    );
    var iosDetails = const DarwinNotificationDetails();
    var notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _notification.zonedSchedule(
      alarmID,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: dateTimeInSecends!)),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  static deleteSchedule(int id) {
    _notification.cancel(id);
  }

  static deleteAllSchedule() {
    _notification.cancelAll();
  }
}
