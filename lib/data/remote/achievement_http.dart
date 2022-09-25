import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../local/login_data.dart';
import '../model/progress_model.dart';
import '../urls.dart';

class AchievementHttp {
  final base = URL.base;
  final token = LoginData.token;

  Future<List<Achievement>> getAllAchievements() async {
    try {
      final response = await get(
        Uri.parse(base + AchievementUrls.getAllAchievements),
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
