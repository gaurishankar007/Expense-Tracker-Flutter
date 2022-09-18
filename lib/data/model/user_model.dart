import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

class UploadUser {
  String? email;
  String? password;
  String? confirmPassword;
  String? profileName;

  UploadUser({
    this.email,
    this.password,
    this.confirmPassword,
    this.profileName,
  });
}

class UploadGoogleUser {
  String? email;
  String? profilePicture;
  String? profileName;

  UploadGoogleUser({
    this.email,
    this.profilePicture,
    this.profileName,
  });
}

@JsonSerializable()
class User {
  @JsonKey(name: "_id")
  String? id;

  String? email;
  String? profileName;
  String? profilePicture;
  String? gender;
  bool? progressPublication;

  User({
    this.id,
    this.email,
    this.profileName,
    this.profilePicture,
    this.gender,
    this.progressPublication,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
