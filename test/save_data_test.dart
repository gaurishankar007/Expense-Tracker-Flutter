import 'package:expense_tracker/data/local/models/token_model.dart';
import 'package:expense_tracker/data/local/login_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  test('Checking TokenData is saved locally or not', () async {
    await Hive.initFlutter();
    Hive.registerAdapter(TokenDataAdapter());
    await Hive.openBox<TokenData>("TokenData");

    LoginData().removeTokenData();

    TokenData? tokenData = LoginData().getTokenData();
    expect(tokenData, null);

    LoginData().addTokenData(
      TokenData(
        token: "abcdef",
        googleSignIn: false,
        profileName: "AB CD",
        profilePicture: "xyz.png",
      ),
    );

    tokenData = LoginData().getTokenData();

    String token = tokenData!.token;
    String profileName = tokenData.profileName;
    String profilePicture = tokenData.profilePicture;
    bool googleSignIn = tokenData.googleSignIn;

    expect(token, "abcdef");
    expect(profileName, "AB CD");
    expect(profilePicture, "xyz.png");
    expect(googleSignIn, false);
  });
}
