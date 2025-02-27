// import 'package:awesome_notifications/awesome_notifications.dart';

// class NotificationService {
//   static Future<void> init() async {
//     // Initialize Awesome Notifications
//     await AwesomeNotifications().initialize(
//       'resource://mipmap/ic_launcher', // Notification icon
//       [
//         NotificationChannel(
//           channelKey: 'repeating_notification_channel',
//           channelName: 'Repeating Notifications',
//           channelDescription: 'Notification channel for repeating reminders',
//           importance: NotificationImportance.High,
//           defaultRingtoneType: DefaultRingtoneType.Notification,
//         ),
//       ],
//     );

//     // Request permission from the user
//     await requestPermission();

//     // Start repeating notifications every 15 minutes
//     scheduleRepeatingNotification();
//   }

//   static Future<void> requestPermission() async {
//     await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//       if (!isAllowed) {
//         AwesomeNotifications().requestPermissionToSendNotifications();
//       }
//     });
//   }

//   static Future<void> scheduleRepeatingNotification() async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 0,
//         channelKey: 'repeating_notification_channel',
//         title: 'Reminder',
//         body: 'Did you forget to add any transactions?',
//         notificationLayout: NotificationLayout.Default,
//       ),
//       schedule: NotificationInterval(
//         interval: Duration(minutes: 60), // 15 minutes (in seconds)
//         timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
//         repeats: true,
//       ),
//     );
//   }
// }

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<void> init() async {
    // Initialize Awesome Notifications
    await AwesomeNotifications().initialize(
      'resource://mipmap/ic_launcher', // Notification icon
      [
        NotificationChannel(
          channelKey: 'repeating_notification_channel',
          channelName: 'Repeating Notifications',
          channelDescription: 'Notification channel for repeating reminders',
          importance: NotificationImportance.High,
          defaultRingtoneType: DefaultRingtoneType.Notification,
        ),
        NotificationChannel(
          channelKey: 'low_balance_channel',
          channelName: 'Low Balance Alerts',
          channelDescription: 'Notification channel for low balance alerts',
          importance: NotificationImportance.High,
          defaultRingtoneType: DefaultRingtoneType.Notification,
        ),
      ],
    );

    // Request permission from the user
    await requestPermission();

    // Start repeating notifications every 15 minutes
    scheduleRepeatingNotification();
  }

  static Future<void> requestPermission() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> scheduleRepeatingNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'repeating_notification_channel',
        title: 'Reminder',
        body: 'Did you forget to add any transactions?',
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationInterval(
        interval: Duration(minutes: 60), // 60 minutes
        timeZone: await AwesomeNotifications().getLocalTimeZoneIdentifier(),
        repeats: true,
      ),
    );
  }

  // Function to send low balance alert notification
  static Future<void> sendLowBalanceNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: 'low_balance_channel',
        title: '⚠️ Low Balance Alert!',
        body: 'Your balance is low!}',
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}

