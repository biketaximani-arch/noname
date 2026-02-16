import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// 🔥 ANDROID FULL SCREEN CHANNEL
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

  const DarwinInitializationSettings iosInit =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initializationSettings =
      InitializationSettings(
    android: androidInit,
    iOS: iosInit,
  );

  /// ✅ FIXED: named parameter `settings`
  await flutterLocalNotificationsPlugin.initialize(
    settings: initializationSettings,
  );

  final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
      flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

  await androidPlugin?.createNotificationChannel(fullScreenChannel);
}

/// 🔥 SHOW FULL SCREEN NOTIFICATION (ANDROID)
Future<void> showFullScreenNotification(Map<String, dynamic> data) async {
  final AndroidNotificationDetails androidDetails =
      AndroidNotificationDetails(
    fullScreenChannel.id,
    fullScreenChannel.name,
    channelDescription: fullScreenChannel.description,
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    sound: const RawResourceAndroidNotificationSound('alarm'),
    enableVibration: true,
    vibrationPattern: Int64List.fromList(
      [0, 1500, 500, 1500, 500, 1500],
    ),
    fullScreenIntent: true,
    category: AndroidNotificationCategory.call,
    visibility: NotificationVisibility.public,
  );

  final NotificationDetails notificationDetails =
      NotificationDetails(android: androidDetails);

  /// ✅ FIXED: ALL named parameters
  await flutterLocalNotificationsPlugin.show(
    id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    title: data['title'] ?? '🚨 Visitor at Gate',
    body: data['body'] ?? 'Tap to approve or deny',
    notificationDetails: notificationDetails,
    payload: 'VISITOR_APPROVAL',
  );
}
