import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:form_field_validator/form_field_validator.dart';

import '../../api/http/authentication/sign_up_http.dart';
import '../../api/model/user_model.dart';
import '../../resource/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "", confirmPassword = "", profileName = "";
  String? gender = "";

  bool hidePass = true;
  bool hideCPass = true;

  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColors.button,
      width: 2,
      style: BorderStyle.solid,
    ),
  );
  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome to Expense Tracker',
          style: TextStyle(
            color: AppColors.iconHeading,
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
            left: _screenWidth * 0.08,
            right: _screenWidth * 0.08,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image(
                    height: 165,
                    width: 165,
                    fit: BoxFit.cover,
                    image: AssetImage("image/logo.png"),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                    filled: true,
                    fillColor: AppColors.button,
                    hintText: "Enter your email.....",
                    hintStyle: TextStyle(
                      color: AppColors.text,
                    ),
                    enabledBorder: formBorder,
                    focusedBorder: formBorder,
                    errorBorder: formBorder,
                    focusedErrorBorder: formBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
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
                    filled: true,
                    fillColor: AppColors.button,
                    hintText: "Enter your profile name.....",
                    hintStyle: TextStyle(
                      color: AppColors.text,
                    ),
                    enabledBorder: formBorder,
                    focusedBorder: formBorder,
                    errorBorder: formBorder,
                    focusedErrorBorder: formBorder,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      onSaved: (value) {
                        password = value!;
                      },
                      validator: (value) {
                        MultiValidator([
                          RequiredValidator(errorText: "Password is required!"),
                        ]);
                        return null;
                      },
                      obscureText: hidePass,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.button,
                        hintText: "Enter a password.....",
                        hintStyle: TextStyle(
                          color: AppColors.text,
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
                          hidePass = !hidePass;
                        });
                      },
                      icon: Icon(
                        hidePass
                            ? FontAwesomeIcons.solidEyeSlash
                            : FontAwesomeIcons.solidEye,
                        size: 18,
                        color: AppColors.iconHeading,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
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
                      obscureText: hideCPass,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.button,
                        hintText: "Enter the password again.....",
                        hintStyle: TextStyle(
                          color: AppColors.text,
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
                          hideCPass = !hideCPass;
                        });
                      },
                      icon: Icon(
                        hideCPass
                            ? FontAwesomeIcons.solidEyeSlash
                            : FontAwesomeIcons.solidEye,
                        size: 18,
                        color: AppColors.iconHeading,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
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
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.green,
                          textColor: AppColors.primary,
                          msg: resData["body"]["resM"],
                        );
                      } else {
                        Fluttertoast.showToast(
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: AppColors.primary,
                          msg: resData["body"]["resM"],
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.red,
                        textColor: AppColors.primary,
                        msg: "Please fill the required form",
                      );
                    }
                  },
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.primary,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
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
