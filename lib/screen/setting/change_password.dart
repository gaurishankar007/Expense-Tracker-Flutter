import 'package:expense_tracker/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../data/remote/user_http.dart';
import '../../config/themes/constant.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  String currentPassword = "", newPassword = "";
  bool curP = true, newP = true;

  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColor.buttonBG,
      width: 2,
      style: BorderStyle.solid,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change Old Password",
          style: TextStyle(
            color: AppColor.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: width * 0.05,
              right: width * 0.05,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        key: Key("CurrentPassword"),
                        onChanged: (value) {
                          currentPassword = value;
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Current password is required!"),
                        ]),
                        obscureText: curP,
                        style: TextStyle(
                          color: AppColor.text,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppColor.buttonBG,
                          hintText: "Enter your current password.....",
                          hintStyle: TextStyle(
                            color: AppColor.textLight,
                          ),
                          enabledBorder: formBorder,
                          focusedBorder: formBorder,
                          errorBorder: formBorder,
                          focusedErrorBorder: formBorder,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            curP = !curP;
                          });
                        },
                        constraints: BoxConstraints(),
                        icon: Icon(
                          curP
                              ? FontAwesomeIcons.solidEyeSlash
                              : FontAwesomeIcons.solidEye,
                          size: 18,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      TextFormField(
                        key: Key("NewPassword"),
                        onChanged: (value) {
                          newPassword = value;
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "New password is required!"),
                        ]),
                        obscureText: newP,
                        style: TextStyle(
                          color: AppColor.text,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: AppColor.buttonBG,
                          hintText: "Enter your New password.....",
                          hintStyle: TextStyle(
                            color: AppColor.textLight,
                          ),
                          helperText:
                              "Most contain at least one upper case, lower case, number, special character, and 5 to 15 characters.",
                          helperMaxLines: 2,
                          helperStyle: TextStyle(
                            color: AppColor.primary,
                          ),
                          enabledBorder: formBorder,
                          focusedBorder: formBorder,
                          errorBorder: formBorder,
                          focusedErrorBorder: formBorder,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            newP = !newP;
                          });
                        },
                        icon: Icon(
                          newP
                              ? FontAwesomeIcons.solidEyeSlash
                              : FontAwesomeIcons.solidEye,
                          size: 18,
                          color: AppColor.primary,
                        ),
                      ),
                    ],
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
                              .changePassword(currentPassword, newPassword);

                          if (resData["statusCode"] == 200) {
                            Navigator.pop(context);

                            Fluttertoast.showToast(
                              msg: "Your password has been changed.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => Home(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: resData["body"]["resM"],
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        }
                      },
                      child: Text(
                        "Change Old Password",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
