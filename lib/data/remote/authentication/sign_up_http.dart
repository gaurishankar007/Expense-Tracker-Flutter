import 'dart:convert';
import 'package:http/http.dart';

import '../../local/login_data.dart';
import '../../model/user_model.dart';
import '../../urls.dart';

class SignUpHttp {
  final base = URL.base;
  final token = LoginData.token;

  Future<Map> signUp(UploadUser userDetails) async {
    try {
      Map<String, String> userData = {
        "email": userDetails.email!,
        "password": userDetails.password!,
        "confirmPassword": userDetails.confirmPassword!,
        "profileName": userDetails.profileName!,
      };

      final response =
          await post(Uri.parse(base + Authentication.register), body: userData);
      return {
        "statusCode": response.statusCode,
        "body": jsonDecode(response.body) as Map,
      };
    } catch (error) {
      return Future.error(error);
    }
  }
}
