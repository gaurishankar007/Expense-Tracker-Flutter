import 'package:expense_tracker/data/log_status.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../data/model/user_model.dart';
import '../../../data/remote/user_http.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';

class UserSetting extends StatefulWidget {
  const UserSetting({Key? key}) : super(key: key);

  @override
  _UserSettingState createState() => _UserSettingState();
}

class _UserSettingState extends State<UserSetting> {
  TextEditingController profileNameController = TextEditingController(),
      emailController = TextEditingController();
  String profileName = "", email = "";
  String? gender;

  bool editEmail = true;

  final _formKey = GlobalKey<FormState>();

  late Future<User> getUser;

  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColor.buttonBG,
      width: 2,
      style: BorderStyle.solid,
    ),
  );

  void loadData() async {
    getUser = UserHttp().getUser();
    getUser.then((value) {
      profileNameController.text = value.profileName!;
      emailController.text = value.email!;
      profileName = value.profileName!;
      email = value.email!;
      gender = value.gender!;
    });

    bool googleSignIn = await LogStatus().googleSignIn();
    if (googleSignIn) {
      editEmail = false;
    }
  }

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Information",
          style: TextStyle(
            color: AppColor.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.text,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            right: width * .04,
            left: width * .04,
          ),
          child: FutureBuilder<User>(
            future: getUser,
            builder: (context, snapshot) {
              List<Widget> children = [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                children = <Widget>[
                  Container(
                    width: width * 0.97,
                    height: height,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Theme.of(context).primaryColor,
                      backgroundColor: AppColor.buttonBG,
                    ),
                  )
                ];
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  children = <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding:
                                EdgeInsets.only(left: 0, right: 0, bottom: 10),
                            minLeadingWidth: 0,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Profile Name:",
                                  style: TextStyle(
                                    color: AppColor.text,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: profileNameController,
                                  onChanged: (value) {
                                    profileName = value.trim();
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText:
                                            "New profile ame is required"),
                                  ]),
                                  style: TextStyle(
                                    color: AppColor.text,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    fillColor: AppColor.buttonBG,
                                    hintText: "Enter new Profile Name",
                                    hintStyle: TextStyle(
                                      color: AppColor.textLight,
                                    ),
                                    helperText:
                                        "Most have 3 to 20 characters. Special characters and numbers are not accepted.",
                                    helperMaxLines: 2,
                                    helperStyle: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    enabledBorder: formBorder,
                                    focusedBorder: formBorder,
                                    errorBorder: formBorder,
                                    focusedErrorBorder: formBorder,
                                  ),
                                )
                              ],
                            ),
                          ),
                          editEmail
                              ? ListTile(
                                  contentPadding: EdgeInsets.only(
                                      left: 0, right: 0, bottom: 10),
                                  minLeadingWidth: 0,
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Email:",
                                        style: TextStyle(
                                          color: AppColor.text,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        onSaved: (value) {
                                          email = value!.trim();
                                        },
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText:
                                                  "New email is required"),
                                        ]),
                                        style: TextStyle(
                                          color: AppColor.text,
                                        ),
                                        decoration: InputDecoration(
                                          isDense: true,
                                          filled: true,
                                          fillColor: AppColor.buttonBG,
                                          hintText: "Enter new Email",
                                          hintStyle: TextStyle(
                                            color: AppColor.textLight,
                                          ),
                                          enabledBorder: formBorder,
                                          focusedBorder: formBorder,
                                          errorBorder: formBorder,
                                          focusedErrorBorder: formBorder,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),
                    ListTile(
                      contentPadding:
                          EdgeInsets.only(left: 0, right: 0, bottom: 10),
                      minLeadingWidth: 0,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Gender:",
                            style: TextStyle(
                              color: AppColor.text,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor),
                                value: "Male",
                                groupValue: gender,
                                onChanged: (String? value) => setState(() {
                                  gender = value;
                                }),
                              ),
                              Text(
                                "Male",
                                style: TextStyle(
                                  color: AppColor.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor),
                                value: "Female",
                                groupValue: gender,
                                onChanged: (String? value) => setState(() {
                                  gender = value;
                                }),
                              ),
                              Text(
                                "Female",
                                style: TextStyle(
                                  color: AppColor.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor),
                                value: "Other",
                                groupValue: gender,
                                onChanged: (String? value) => setState(() {
                                  gender = value;
                                }),
                              ),
                              Text(
                                "Other",
                                style: TextStyle(
                                  color: AppColor.text,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            final resData = await UserHttp()
                                .changeProfileInfo(email, profileName, gender!);

                            if (resData["statusCode"] == 200) {
                              Navigator.pop(context);
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
                          }
                        },
                        child: Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
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
                      )
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
      ),
    );
  }
}
