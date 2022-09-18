import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../log_status.dart';
import '../model/progress_model.dart';
import '../urls.dart';

class AchievementHttp {
  final baseUrl = ApiUrls.baseUrl;
  final token = LogStatus.token;

  Future<List<Achievement>> getAllAchievements() async {
    try {
      final response = await get(
        Uri.parse(baseUrl + AchievementUrls.getAllAchievements),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      List resData = jsonDecode(response.body);

      return resData.map((e) => Achievement.fromJson(e)).toList();
    } catch (error) {
      return Future.error(error);
    }
  }
}
