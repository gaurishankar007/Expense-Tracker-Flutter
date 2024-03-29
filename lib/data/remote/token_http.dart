import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../local/login_data.dart';
import '../urls.dart';

class TokenHttp {
  final base = URL.base;
  final token = LoginData.token;

  Future<Map> generateToken(String email, String password) async {
    try {
      final response = await post(
        Uri.parse(base + TokenUrls.generateToken),
        body: {"email": email, "password": password},
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> verifyToken(String tokenNumber, String userId) async {
    try {
      final response = await put(
        Uri.parse(base + TokenUrls.verifyToken),
        body: {"tokenNumber": tokenNumber, "userId": userId},
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body)
      };
    } catch (error) {
      return Future.error(error);
    }
  }
}
