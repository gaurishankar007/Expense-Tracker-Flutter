import 'package:expense_tracker/data/local/models/token_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginData {
  static String token = "";
  static String profileName = "";
  static String profilePicture = "";
  static bool googleSignIn = false;

  final box = Hive.box<TokenData>("TokenData");

  void addTokenData(TokenData tokenData) async {
    box.put(
      "tokenData",
      tokenData,
    );

    LoginData.token = tokenData.token;
    LoginData.profileName = tokenData.profileName;
    LoginData.profilePicture = tokenData.profilePicture;
  }

  void addTokenDataG(TokenData tokenData) async {
    box.put(
      "tokenData",
      tokenData,
    );

    LoginData.token = tokenData.token;
    LoginData.googleSignIn = true;
    LoginData.profileName = tokenData.profileName;
    LoginData.profilePicture = tokenData.profilePicture;
  }

  TokenData? getTokenData() {
    return box.get("tokenData");
  }

  void removeTokenData() async {
    box.delete("tokenData");
    LoginData.token = "";
    LoginData.profileName = "";
    LoginData.profilePicture = "";
    LoginData.googleSignIn = false;
  }
}
