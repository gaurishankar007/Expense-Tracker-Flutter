import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../data/remote/user_http.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';

class PasswordSetting extends StatefulWidget {
  const PasswordSetting({Key? key}) : super(key: key);

  @override
  _PasswordSettingState createState() => _PasswordSettingState();
}

class _PasswordSettingState extends State<PasswordSetting> {
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
          "Password",
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 10,
              left: width * 0.04,
              right: width * 0.04,
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
                            color: AppColor.lightText,
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
                          color: Theme.of(context).primaryColor,
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
                            color: AppColor.lightText,
                          ),
                          helperText:
                              "Most contain at least one upper case, lower case, number, special character, and 5 to 15 characters.",
                          helperMaxLines: 2,
                          helperStyle: TextStyle(
                            color: Theme.of(context).primaryColor,
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
                          color: Theme.of(context).primaryColor,
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

                            Message(
                              message: "Your password has been changed.",
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
                        "Change Password",
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
