import 'package:hive/hive.dart';

part 'token_model.g.dart';

@HiveType(typeId: 1)
class TokenData extends HiveObject {
  @HiveField(0)
  String token;

  @HiveField(1)
  bool googleSignIn;

  @HiveField(2)
  String profileName;

  @HiveField(3)
  String profilePicture;

  TokenData({
    required this.token,
    required this.googleSignIn,
    required this.profileName,
    required this.profilePicture,
  });
}
