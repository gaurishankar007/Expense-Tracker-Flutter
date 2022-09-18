import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../log_status.dart';
import '../model/home_model.dart';
import '../urls.dart';

class HomeHttp {
  final baseUrl = ApiUrls.baseUrl;
  final token = LogStatus.token;

  Future<HomeData> viewHome() async {
    try {
      final response = await get(
        Uri.parse(baseUrl + HomeUrls.viewHome),
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
