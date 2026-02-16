import 'dart:async';

import 'package:noname/core/notification_service.dart';



import 'notification_service.dart';


Timer? _unlockRepeatTimer;
int _unlockCount = 0;

void startUnlockAlert(Map<String, dynamic> data) {
  _unlockCount = 0;

  _unlockRepeatTimer?.cancel();
  _unlockRepeatTimer = Timer.periodic(
    const Duration(seconds: 7), // 🔥 7 SECONDS
        (timer) {
      if (_unlockCount >= 9) { // 9 × 7s ≈ 63 seconds
        timer.cancel();
        return;
      }

      showFullScreenNotification(data);
      _unlockCount++;
    },
  );
}

void stopUnlockAlert() {
  _unlockRepeatTimer?.cancel();
}

