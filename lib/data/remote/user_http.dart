// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../log_status.dart';
import '../model/user_model.dart';
import '../urls.dart';
import "package:http_parser/http_parser.dart";

class UserHttp {
  final baseUrl = ApiUrls.baseUrl;
  final token = LogStatus.token;

  Future<Map> changePassword(String currentPassword, String newPassword) async {
    try {
      Map<String, String> userData = {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
      };

      final response = await put(
        Uri.parse(baseUrl + UserUrls.changePassword),
        body: userData,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body) as Map,
      };
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<bool> checkPassword() async {
    try {
      final response = await get(
        Uri.parse(baseUrl + UserUrls.checkPassword),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return jsonDecode(response.body);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<User> getUser() async {
    try {
      final response = await get(
        Uri.parse(baseUrl + UserUrls.getUser),
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      return User.fromJson(jsonDecode(response.body));
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> changeProfilePicture(File profilePicture) async {
    try {
      // Making multipart request
      var request = http.MultipartRequest(
          'PUT', Uri.parse(baseUrl + UserUrls.changeProfilePicture));

      // Adding headers
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });

      // Adding images
      MultipartFile profile = http.MultipartFile(
        'profile',
        profilePicture.readAsBytes().asStream(),
        profilePicture.lengthSync(),
        filename: profilePicture.path.split('/').last,
        contentType: MediaType(
          "image",
          "png",
        ),
      );

      request.files.add(profile);

      final response = await request.send();
      var responseString = await response.stream.bytesToString();
      final responseData = jsonDecode(responseString) as Map;
      return {
        "statusCode": response.statusCode,
        "body": responseData,
      };
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> changeProfileInfo(
      String email, String profileName, String gender) async {
    try {
      final response = await put(
        Uri.parse(baseUrl + UserUrls.changeProfileInfo),
        body: {
          "email": email,
          "profileName": profileName,
          "gender": gender,
        },
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
      );

      final responseData = jsonDecode(response.body);
      return {
        "statusCode": response.statusCode,
        "body": responseData as Map,
      };
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<Map> publicProgress() async {
    try {
      final response = await get(
        Uri.parse(baseUrl + UserUrls.publicProgress),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      return jsonDecode(response.body) as Map;
    } catch (error) {
      return Future.error(error);
    }
  }
}
