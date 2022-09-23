import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:expense_tracker/data/google/google_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/model/user_model.dart';
import '../../../data/remote/user_http.dart';
import '../../../../data/log_status.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';
import '../../widgets/shimmer/setting_shimmer.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Future<User> getUser;
  bool progressPublication = false;

  void userData() async {
    getUser = UserHttp().getUser();
    User userData = await getUser;

    setState(() {
      progressPublication = userData.progressPublication!;
    });
  }

  @override
  void initState() {
    super.initState();
    userData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.text,
          ),
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: AppColor.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          right: width * .04,
          bottom: 25,
          left: width * .04,
        ),
        child: FutureBuilder<User>(
          future: getUser,
          builder: (context, snapshot) {
            List<Widget> children = [];
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerEffect();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                children = <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: CachedNetworkImage(
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          imageUrl: snapshot.data!.profilePicture!,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(
                            strokeWidth: 10,
                            color: Theme.of(context).primaryColor,
                            backgroundColor: AppColor.buttonBG,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (builder) => pickPlatform(
                              context: context,
                              width: width,
                            ),
                          );
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppColor.onPrimary,
                          size: 30,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(10),
                          minimumSize: Size.zero,
                          backgroundColor: Theme.of(context).primaryColor,
                          elevation: 10,
                          shadowColor: AppColor.text,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
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
                      color: AppColor.text,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/userSetting",
                      );
                    },
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Theme.of(context).primaryColor,
                          size: AppSize.icon,
                        ),
                      ],
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Update your personal information",
                      style: TextStyle(
                        color: AppColor.textLight,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/passwordSetting",
                      );
                    },
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                          size: AppSize.icon,
                        ),
                      ],
                    ),
                    title: Text(
                      "Password",
                      style: TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Change your password",
                      style: TextStyle(
                        color: AppColor.textLight,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                    onTap: () async {
                      final resData = await UserHttp().publicProgress();

                      Message(
                        message: resData["resM"],
                        time: 3,
                        bgColor: Colors.green,
                        textColor: AppColor.onPrimary,
                      ).showMessage;

                      setState(() {
                        progressPublication = !progressPublication;
                      });
                    },
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.public,
                          color: Theme.of(context).primaryColor,
                          size: AppSize.icon,
                        ),
                      ],
                    ),
                    title: Text(
                      "Progress Publication",
                      style: TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Share your progress points and achievements",
                      style: TextStyle(
                        color: AppColor.textLight,
                      ),
                    ),
                    trailing: SizedBox(
                      width: 25,
                      child: Switch(
                        activeColor: Theme.of(context).primaryColor,
                        inactiveThumbColor: AppColor.text,
                        value: progressPublication,
                        onChanged: (value) async {
                          final resData = await UserHttp().publicProgress();

                          Message(
                            message: resData["resM"],
                            time: 3,
                            bgColor: Colors.green,
                            textColor: AppColor.onPrimary,
                          ).showMessage;
                          setState(() {
                            progressPublication = value;
                          });
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/help",
                      );
                    },
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.help_rounded,
                          color: Theme.of(context).primaryColor,
                          size: AppSize.icon,
                        ),
                      ],
                    ),
                    title: Text(
                      "Help",
                      style: TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Learn about the app",
                      style: TextStyle(
                        color: AppColor.textLight,
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    horizontalTitleGap: 0,
                    minVerticalPadding: 0,
                    visualDensity: VisualDensity(horizontal: -4, vertical: -2),
                    onTap: () async {
                      LogStatus().removeToken();
                      LogStatus.token = "";

                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/login",
                        (route) => false,
                      );

                      bool googleSignIn = await LogStatus().googleSignIn();
                      if (googleSignIn) {
                        await GoogleSingInApi.logout();
                        LogStatus().removeGoogleSignIn();
                      }
                    },
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: Theme.of(context).primaryColor,
                          size: AppSize.icon,
                        ),
                      ],
                    ),
                    title: Text(
                      "Log out",
                      style: TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Logged in as " + snapshot.data!.profileName!,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColor.textLight,
                      ),
                    ),
                  ),
                ];
              } else if (snapshot.hasError) {
                if ("${snapshot.error}".split("Exception: ")[0] == "Socket") {
                  children = <Widget>[
                    Container(
                      width: width,
                      height: height,
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
                      width: width,
                      height: height,
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

  Widget pickPlatform({required context, required width}) {
    return Container(
      height: 70,
      width: width,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final xImage =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              if (xImage == null) return;

              File image = File(xImage.path);
              String imageType = image.path.split("/").last.split(".").last;
              List<String> validImages = ["jpg", "jpeg", "png"];

              if (!validImages.contains(imageType)) {
                Message(
                  message: "Only jpg and png image formats are supported.",
                  time: 4,
                  bgColor: Colors.white,
                  textColor: AppColor.text,
                ).showMessage;
                return;
              }

              final resData =
                  await UserHttp().changeProfilePicture(File(image.path));
              if (resData["statusCode"] == 200) {
                setState(() {
                  getUser = UserHttp().getUser();
                });

                Message(
                  message: resData["body"]["resM"],
                  time: 3,
                  bgColor: Colors.green,
                  textColor: AppColor.onPrimary,
                ).showMessage;
              } else {
                Message(
                  message: resData["body"]["resM"],
                  time: 3,
                  bgColor: Colors.red,
                  textColor: AppColor.onPrimary,
                ).showMessage;
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              textStyle: TextStyle(
                fontSize: AppSize.subtitleBody1["size"],
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              elevation: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  FontAwesomeIcons.camera,
                  size: AppSize.icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Camera",
                )
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final xImage =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              if (xImage == null) return;

              File image = File(xImage.path);
              String imageType = image.path.split("/").last.split(".").last;
              List<String> validImages = ["jpg", "jpeg", "png"];

              if (!validImages.contains(imageType)) {
                Message(
                  message: "Only jpg and png image formats are supported.",
                  time: 4,
                  bgColor: Colors.white,
                  textColor: AppColor.text,
                ).showMessage;
                return;
              }

              final resData =
                  await UserHttp().changeProfilePicture(File(image.path));
              if (resData["statusCode"] == 200) {
                setState(() {
                  getUser = UserHttp().getUser();
                });

                Message(
                  message: resData["body"]["resM"],
                  time: 3,
                  bgColor: Colors.green,
                  textColor: AppColor.onPrimary,
                ).showMessage;
              } else {
                Message(
                  message: resData["body"]["resM"],
                  time: 3,
                  bgColor: Colors.red,
                  textColor: AppColor.onPrimary,
                ).showMessage;
              }
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              backgroundColor: AppColor.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  5,
                ),
              ),
              textStyle: TextStyle(
                fontSize: AppSize.subtitleBody1["size"],
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              elevation: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  FontAwesomeIcons.image,
                  size: AppSize.icon,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Gallery",
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
