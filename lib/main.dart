import 'package:flutter/material.dart';
import 'package:noname/core/alert_controller.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:noname/MVVM/logInPage/logInPageView.dart';
import 'package:noname/MVVM/logInPage/logInPageViewModel.dart';
import 'package:noname/MVVM/OTPVerificationScreen/OTPVerificationScreenViewModel.dart';
import 'package:noname/MVVM/OTPVerificationScreen/auth_view_model.dart';
import 'package:noname/MVVM/AdminAndUser/HomePage/HomePageViewModel.dart';

import 'core/notification_service.dart';
import 'core/notification_bridge.dart';


/// 🔥 BACKGROUND FCM HANDLER
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp();
  }

  if (message.data['type'] == 'VISITOR_APPROVAL') {
    await showFullScreenNotification(message.data);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1️⃣ Firebase
  await Firebase.initializeApp();

  // 2️⃣ Local notifications (channel + full screen)
  await initNotifications();

  // 3️⃣ Android 13+ permission
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // 4️⃣ Background handler
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  // 5️⃣ Run app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => OTPVerificationViewModel()),
        ChangeNotifierProvider(create: (_) => Homepageviewmodel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();

    // 🔥 FOREGROUND / UNLOCKED
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.data.isNotEmpty &&
          message.data['type'] == 'VISITOR_APPROVAL') {
        // showFullScreenNotification(message.data);
        startUnlockAlert(message.data); // 🔥 KEY
      }
    });

    // 🔥 USER TAP (BACKGROUND / KILLED)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.data.isNotEmpty &&
          message.data['type'] == 'VISITOR_APPROVAL') {
        stopUnlockAlert(); // 🔥 stop repeat
        NotificationBridge.openApprovalPage(message.data);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NotificationBridge.navigatorKey,
      home: const OtpLoginScreen(),
    );
  }
}

