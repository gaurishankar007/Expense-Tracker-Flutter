import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../api/http/user_http.dart';
import '../../resource/colors.dart';

class PasswordSetting extends StatefulWidget {
  const PasswordSetting({Key? key}) : super(key: key);

  @override
  _PasswordSettingState createState() => _PasswordSettingState();
}

class _PasswordSettingState extends State<PasswordSetting> {
  final _formKey = GlobalKey<FormState>();
  String currentPassword = "", newPassword = "", confirmPassword = "";
  bool curP = true, newP = true, conP = true;

  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColors.form,
      width: 2,
      style: BorderStyle.solid,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Password",
          style: TextStyle(
            color: AppColors.text,
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
            color: AppColors.text,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: sWidth * 0.08,
              right: sWidth * 0.08,
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
                          color: AppColors.text,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.form,
                          hintText: "Enter your current password.....",
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
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
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
                          color: AppColors.text,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.form,
                          hintText: "Enter your New password.....",
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
                        constraints: BoxConstraints(),
                        icon: Icon(
                          newP
                              ? FontAwesomeIcons.solidEyeSlash
                              : FontAwesomeIcons.solidEye,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      TextFormField(
                        key: Key("ConfirmPassword"),
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        validator: MultiValidator([
                          RequiredValidator(
                              errorText: "Confirm password is required!"),
                        ]),
                        obscureText: conP,
                        style: TextStyle(
                          color: AppColors.text,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.form,
                          hintText: "Confirm New Password......",
                          enabledBorder: formBorder,
                          focusedBorder: formBorder,
                          errorBorder: formBorder,
                          focusedErrorBorder: formBorder,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            conP = !conP;
                          });
                        },
                        constraints: BoxConstraints(),
                        icon: Icon(
                          conP
                              ? FontAwesomeIcons.solidEyeSlash
                              : FontAwesomeIcons.solidEye,
                          size: 20,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        if (confirmPassword != newPassword) {
                          Fluttertoast.showToast(
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            msg:
                                "Confirm password and new password must be same",
                          );
                          return;
                        }

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
                      "Change Password",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: AppColors.primary,
                      elevation: 10,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
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
