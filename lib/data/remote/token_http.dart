import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../log_status.dart';
import '../urls.dart';

class TokenHttp {
  final baseUrl = ApiUrls.baseUrl;
  final token = LogStatus.token;

  Future<Map> generateToken(String email, String password) async {
    try {
      final response = await post(
        Uri.parse(baseUrl + TokenUrls.generateToken),
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
        Uri.parse(baseUrl + TokenUrls.verifyToken),
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
