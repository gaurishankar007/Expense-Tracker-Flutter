import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../log_status.dart';
import '../model/progress_model.dart';
import '../urls.dart';

class ProgressHttp {
  final baseUrl = ApiUrls.baseUrl;
  final token = LogStatus.token;

  Future<ProgressData> getUserProgress() async {
    try {
      final response = await get(
        Uri.parse(baseUrl + ProgressUrls.getUserProgress),
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
        Uri.parse(baseUrl + ProgressUrls.topUsersProgress),
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
        Uri.parse(baseUrl + ProgressUrls.calculateProgress),
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
