import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../data/remote/token_http.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";

  bool p = true;
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
          "Forgot Password",
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
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.04,
            right: width * 0.04,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  key: ValueKey("email"),
                  onSaved: (value) {
                    email = value!;
                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(errorText: "Email is required!"),
                    ]);
                    return null;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.buttonBG,
                    hintText: "Enter your email.....",
                    hintStyle: TextStyle(
                      color: AppColor.lightText,
                    ),
                    enabledBorder: formBorder,
                    focusedBorder: formBorder,
                    errorBorder: formBorder,
                    focusedErrorBorder: formBorder,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    TextFormField(
                      key: ValueKey("password"),
                      onChanged: (value) {
                        password = value;
                      },
                      validator: MultiValidator([
                        RequiredValidator(
                            errorText: "New password is required!"),
                      ]),
                      obscureText: p,
                      style: TextStyle(
                        color: AppColor.text,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: AppColor.buttonBG,
                        hintText: "Enter a new password.....",
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
                          p = !p;
                        });
                      },
                      icon: Icon(
                        p
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

                        final resData =
                            await TokenHttp().generateToken(email, password);

                        if (resData["statusCode"] == 201) {
                          Navigator.pushNamed(
                            context,
                            "/verifyToken",
                            arguments: resData["body"]["userId"],
                          );
                          Message(
                            message: "Token generated. Check your email.",
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
                      "Get Token",
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
    );
  }
}
