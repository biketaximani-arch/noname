import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:noname/core/api_service.dart';
import 'package:noname/core/APIClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';



class OTPVerificationViewModel extends ChangeNotifier {

  Future<bool> VerfiOTP({
    required String mobile,
    required String otp, // ✅ FIX
  }) async {
    try {
      await Firebase.initializeApp();

      // 🔔 FCM TOKEN CHECK
      String? token = await FirebaseMessaging.instance.getToken();
      print("🔥 FCM TOKEN: $token");


      final url =
          "${ApiConstants.baseURL}${ApiConstants.dbURL}VerfyOTP&mobile=$mobile&otp=$otp&fcmTokan=$token";

      final response = await ApiService.get(url);

      print("OTP API Response: $response");

      if (response['status'] == true) {

        final user = response['userdetails'][0];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userDetails', jsonEncode(user));

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      return false;
    }
  }
}


