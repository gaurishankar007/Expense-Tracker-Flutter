import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../local/login_data.dart';
import '../model/progress_model.dart';
import '../urls.dart';

class ProgressHttp {
  final base = URL.base;
  final token = LoginData.token;

  Future<ProgressData> getUserProgress() async {
    try {
      final response = await get(
        Uri.parse(base + ProgressUrls.getUserProgress),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      final resData = jsonDecode(response.body);

      return ProgressData.fromJson(resData);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<TopProgress> topUsersProgress() async {
    try {
      final response = await get(
        Uri.parse(base + ProgressUrls.topUsersProgress),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      final resData = jsonDecode(response.body);

      return TopProgress.fromJson(resData);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> calculateProgress() async {
    try {
      final response = await get(
        Uri.parse(base + ProgressUrls.calculateProgress),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return jsonDecode(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }
}
