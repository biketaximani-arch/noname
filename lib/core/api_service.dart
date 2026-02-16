import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:noname/core/config.dart';

class ApiService {

  // COMMON HEADERS
  static Map<String, String> _headers() {
    return {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "X-API-KEY": ApiToken.token,
    };
  }

  // COMMON GET
  static Future<dynamic> get(String URLString) async {
    final url = Uri.parse(URLString);

    final response = await http.get(url, headers: _headers());
    return _handleResponse(response);
  }

  // COMMON POST
  static Future<dynamic> post(String URLString, Map<String, dynamic> body) async {
    final url = Uri.parse(URLString);

    final response = await http.post(
      url,
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  // RESPONSE HANDLING
  static dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("API Error: ${response.statusCode}");
    }
  }
}
