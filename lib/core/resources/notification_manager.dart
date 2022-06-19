import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationManager {
  static Future<void> createScheduleNotifi(DateTime time) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: Random().nextInt(pow(2, 31) as int),
        channelKey: 'scheduled_channel',
        title: 'Your trip has just begun!',
        body: 'Tap to track your bus',
      ),
      schedule: NotificationCalendar.fromDate(date: time),
    );
  }
}
