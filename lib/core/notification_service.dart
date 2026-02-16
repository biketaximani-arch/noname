
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

/// 🔥 FULL SCREEN CHANNEL
const AndroidNotificationChannel fullScreenChannel =
AndroidNotificationChannel(
'full_screen_channel',
'Full Screen Alerts',
description: 'Urgent notifications',
importance: Importance.max,
);

/// 🔹 INIT NOTIFICATIONS
Future<void> initNotifications() async {
const AndroidInitializationSettings androidInit =
AndroidInitializationSettings('@mipmap/ic_launcher');

const InitializationSettings initializationSettings =
InitializationSettings(android: androidInit);

await flutterLocalNotificationsPlugin.initialize(
settings: initializationSettings,
);

final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
flutterLocalNotificationsPlugin
    .resolvePlatformSpecificImplementation<
AndroidFlutterLocalNotificationsPlugin>();

await androidPlugin?.createNotificationChannel(fullScreenChannel);
}

/// 🔥 SHOW FULL SCREEN / HEADS-UP NOTIFICATION
Future<void> showFullScreenNotification(Map<String, dynamic> data) async {
final AndroidNotificationDetails androidDetails =
AndroidNotificationDetails(
fullScreenChannel.id,
fullScreenChannel.name,
channelDescription: fullScreenChannel.description,

// 🔥 Heads-up mandatory
importance: Importance.max,
priority: Priority.high,

// 🔊 Loud sound
sound: const RawResourceAndroidNotificationSound('alarm'),
playSound: true,

// 📳 Strong vibration
enableVibration: true,
vibrationPattern: Int64List.fromList([
0, 1500, 500, 1500, 500, 1500
]),

// 🔒 Lock screen → full screen
fullScreenIntent: true,

category: AndroidNotificationCategory.call,
visibility: NotificationVisibility.public,
);

final NotificationDetails notificationDetails =
NotificationDetails(android: androidDetails);

await flutterLocalNotificationsPlugin.show(
id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
title: data['title'] ?? '🚨 Visitor at Gate',
body: data['body'] ?? 'Tap to approve or deny',
notificationDetails: notificationDetails,
payload: 'VISITOR_APPROVAL',
);
}









//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// /// 🔥 FULL SCREEN CHANNEL
// const AndroidNotificationChannel fullScreenChannel =
//     AndroidNotificationChannel(
//   'full_screen_channel',
//   'Full Screen Alerts',
//   description: 'Urgent notifications',
//   importance: Importance.max,
// );
//
// /// 🔹 INIT (v20 STRICT SIGNATURE)
// Future<void> initNotifications() async {
//   const AndroidInitializationSettings androidInit =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//
//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: androidInit);
//
//   // ❗ MUST use named parameter `settings`
//   await flutterLocalNotificationsPlugin.initialize(
//     settings: initializationSettings,
//   );
//
//   final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
//       flutterLocalNotificationsPlugin
//           .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin>();
//
//   await androidPlugin?.createNotificationChannel(fullScreenChannel);
// }
//
// /// 🔥 SHOW FULL SCREEN NOTIFICATION (ALL NAMED PARAMS)
// Future<void> showFullScreenNotification(
//     Map<String, dynamic> data) async {
//   final AndroidNotificationDetails androidDetails =
//       AndroidNotificationDetails(
//     fullScreenChannel.id,
//     fullScreenChannel.name,
//     channelDescription: fullScreenChannel.description,
//     importance: Importance.max,
//     priority: Priority.high,
//     fullScreenIntent: true,
//     category: AndroidNotificationCategory.call,
//     visibility: NotificationVisibility.public,
//   );
//
//   final NotificationDetails notificationDetails =
//       NotificationDetails(android: androidDetails);
//
//   // ❗ v20 → ALL named arguments
//   await flutterLocalNotificationsPlugin.show(
//     id: 101,
//     title: 'Visitor MANI at Gate 🚪',
//     body: 'Approve or Reject',
//     notificationDetails: notificationDetails,
//   );
// }

