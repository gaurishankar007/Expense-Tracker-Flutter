import 'package:flutter/material.dart';

import 'package:form_field_validator/form_field_validator.dart';

import '../../../data/remote/authentication/sign_up_http.dart';
import '../../../../data/model/user_model.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "", confirmPassword = "", profileName = "";
  String? gender = "";

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
          'Welcome to Expense Tracker',
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                    image: AssetImage("image/logo.png"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                TextFormField(
                  key: ValueKey("profileName"),
                  onSaved: (value) {
                    profileName = value!;
                  },
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(errorText: "Profile name is required!"),
                    ]);
                    return null;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.buttonBG,
                    hintText: "Enter your profile name.....",
                    hintStyle: TextStyle(
                      color: AppColor.lightText,
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
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  key: ValueKey("password"),
                  onSaved: (value) {
                    password = value!;
                  },
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(errorText: "Password is required!"),
                    ]);
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.buttonBG,
                    hintText: "Enter a password.....",
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
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  key: ValueKey("confirmPassword"),
                  onSaved: (value) {
                    confirmPassword = value!;
                  },
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(
                          errorText: "Password confirmation is required!"),
                    ]);
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.buttonBG,
                    hintText: "Enter the password again.....",
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
                SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        final resData = await SignUpHttp().signUp(
                          UploadUser(
                            email: email,
                            profileName: profileName,
                            password: password,
                            confirmPassword: confirmPassword,
                          ),
                        );
                        if (resData["statusCode"] == 201) {
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
                            bgColor: Colors.green,
                            textColor: AppColor.onPrimary,
                          ).showMessage;
                        }
                      } else {
                        Message(
                          message: "Please fill the required form",
                          time: 3,
                          bgColor: Colors.green,
                          textColor: AppColor.onPrimary,
                        ).showMessage;
                      }
                    },
                    child: Text(
                      "Register",
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
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
