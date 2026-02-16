import 'package:flutter/material.dart';
import 'package:noname/core/APIClient.dart';
import 'package:noname/core/api_service.dart';


class Homepageviewmodel extends ChangeNotifier {


  Future<bool> sendNotification({
    required String mobile,
  }) async {
    try {
      final url =
          "${ApiConstants.baseURL}${ApiConstants.dbURL}sendpush&mobile=$mobile";

      final response = await ApiService.get(url);

      print("SEND PUSH API RESPONSE: $response");

      // PHP success response example check
      if (response != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error sending push: $e");
      return false;
    }
  }


}