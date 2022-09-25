import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../local/login_data.dart';
import '../model/home_model.dart';
import '../urls.dart';

class HomeHttp {
  final base = URL.base;
  final token = LoginData.token;

  Future<HomeData> viewHome() async {
    try {
      final response = await get(
        Uri.parse(base + HomeUrls.viewHome),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return HomeData.fromJson(jsonDecode(response.body));
    } catch (error) {
      return Future.error(error);
    }
  }
}
