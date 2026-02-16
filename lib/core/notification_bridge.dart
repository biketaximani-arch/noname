import 'package:flutter/material.dart';
import '../MVVM/AdminAndUser/HomePage/approval_page.dart';

class NotificationBridge {
  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static void openApprovalPage(Map<String, dynamic> data) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => ApprovalPage(
          visitorId: data['visitor_id'],
        ),
      ),
    );
  }
}

