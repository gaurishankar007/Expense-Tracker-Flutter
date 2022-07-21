import 'dart:io';

import 'package:expense_tracker/api/google/google_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../api/http/user_http.dart';
import '../api/log_status.dart';
import '../api/res/user_res.dart';
import '../resource/colors.dart';
import 'authentication/login.dart';
import 'setting/password_setting.dart';
import 'setting/user_setting.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Future<User> getUser;
  bool progressPublication = false;

  @override
  void initState() {
    super.initState();
    UserHttp().getUser().then((value) {
      setState(() {
        progressPublication = value.progressPublication!;
      });
    });
    getUser = UserHttp().getUser();
  }

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;
    final sHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.iconHeading,
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppColors.iconHeading,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          right: sWidth * .05,
          bottom: 25,
          left: sWidth * .05,
        ),
        child: FutureBuilder<User>(
          future: getUser,
          builder: (context, snapshot) {
            List<Widget> children = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              children = <Widget>[
                Container(
                  width: sWidth * 0.97,
                  height: sHeight,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    color: AppColors.primary,
                    backgroundColor: AppColors.button,
                  ),
                )
              ];
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                children = <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            NetworkImage(snapshot.data!.profilePicture!),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (builder) => pickPlatform(context),
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColors.onPrimary,
                          size: 25,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(4),
                          minimumSize: Size.zero,
                          primary: AppColors.primary,
                          elevation: 10,
                          shadowColor: AppColors.iconHeading,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    snapshot.data!.profileName!,
                    style: TextStyle(
                      color: AppColors.iconHeading,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => UserSetting(),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: AppColors.iconHeading,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Update your personal information."),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.person,
                        color: AppColors.iconHeading,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PasswordSetting(),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Password",
                              style: TextStyle(
                                color: AppColors.iconHeading,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Change your password."),
                          ],
                        ),
                        Icon(
                          Icons.key,
                          color: AppColors.iconHeading,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profile Publication",
                            style: TextStyle(
                              color: AppColors.iconHeading,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Publish Profile Information",
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 25,
                        child: Switch(
                          activeColor: AppColors.primary,
                          inactiveThumbColor: AppColors.iconHeading,
                          value: progressPublication,
                          onChanged: (value) async {
                            final resData = await UserHttp().publicProgress();
                            Fluttertoast.showToast(
                              msg: resData["resM"],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              fontSize: 16.0,
                            );
                            setState(() {
                              progressPublication = value;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () async {
                      bool googleSignIn = await LogStatus().googleSignIn();
                      if (googleSignIn) {
                        await GoogleSingInApi.logout();
                      }
                      LogStatus().removeGoogleSignIn();
                      LogStatus().removeToken();
                      LogStatus.token = "";

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (builder) => Login(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Log out",
                              style: TextStyle(
                                color: AppColors.iconHeading,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "You are currently logged in",
                            ),
                          ],
                        ),
                        Icon(
                          Icons.logout_outlined,
                          color: AppColors.iconHeading,
                        ),
                      ],
                    ),
                  ),
                ];
              } else if (snapshot.hasError) {
                if ("${snapshot.error}".split("Exception: ")[0] == "Socket") {
                  children = <Widget>[
                    Container(
                      width: sWidth,
                      height: sHeight,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.warning_rounded,
                            size: 25,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Connection Problem",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ];
                } else {
                  children = <Widget>[
                    Container(
                      width: sWidth,
                      height: sHeight,
                      alignment: Alignment.center,
                      child: Text(
                        "${snapshot.error}",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    )
                  ];
                }
              }
            }
            return Column(
              children: children,
            );
          },
        ),
      ),
    );
  }

  Widget pickPlatform(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColors.background,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                final image =
                    await ImagePicker().pickImage(source: ImageSource.camera);

                if (image == null) return;

                await UserHttp().changeProfilePicture(File(image.path));
                setState(() {
                  getUser = UserHttp().getUser();
                });
                Fluttertoast.showToast(
                  msg: "Your profile picture updated.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.camera,
                    size: 18,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                primary: AppColors.primary,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                final image =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                if (image == null) return;

                await UserHttp().changeProfilePicture(File(image.path));
                setState(() {
                  getUser = UserHttp().getUser();
                });
                Fluttertoast.showToast(
                  msg: "Your profile picture updated.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                );
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.photo_album,
                    size: 18,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Gallery",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  )
                ],
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                primary: AppColors.primary,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
