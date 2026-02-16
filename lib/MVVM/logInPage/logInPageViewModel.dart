import 'package:flutter/material.dart';
import 'package:noname/core/api_service.dart';
import 'package:noname/core/APIClient.dart';

class LoginViewModel extends ChangeNotifier {


  bool isLoading = false;
  String? errorMessage;


  Future<void> getUserById() async {
    try {
      final response = await ApiService.get("${ApiConstants.baseURL}${ApiConstants.dbURL}getDistReport");
      print(response);
      print("ok mani");
    } catch (e) {
      print("Xxxxxxxx______");
      print(e);
      print("ok mani");
    }
  }

  Future<bool> sendOTP({required String mobile}) async {
    try {
      final url =
          "${ApiConstants.baseURL}${ApiConstants.dbURL}SendOTP&mobile=$mobile";

      final response = await ApiService.get(url);

      print("OTP API Response: $response");

      // Example: response = {"status": true}
      if (response['status'] == true) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
    }
  }
}
