import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../../../data/google/google_sign_up.dart';
import '../../../data/remote/authentication/login_http.dart';
import '../../../../data/log_status.dart';
import '../../../../data/model/user_model.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";
  bool hidePass = true;
  bool checkboxValue = false;

  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColor.buttonBG,
      width: 2,
      style: BorderStyle.solid,
    ),
  );
  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Colors.black87,
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Expense Tracker",
          style: TextStyle(
            color: AppColor.text,
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
          left: width * .04,
          right: width * .04,
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    key: ValueKey("email"),
                    onSaved: (value) {
                      email = value!;
                    },
                    keyboardType: TextInputType.emailAddress,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Email is required!"),
                    ]),
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
                  Text(
                    "Password",
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextFormField(
                            key: ValueKey("password"),
                            onSaved: (value) {
                              password = value!.trim();
                            },
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Password is required!"),
                            ]),
                            obscureText: hidePass,
                            decoration: InputDecoration(
                              isDense: true,
                              filled: true,
                              fillColor: AppColor.buttonBG,
                              hintText: "Enter your password.....",
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
                                hidePass = !hidePass;
                              });
                            },
                            icon: Icon(
                              hidePass
                                  ? FontAwesomeIcons.solidEyeSlash
                                  : FontAwesomeIcons.solidEye,
                              size: 18,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 160,
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              visualDensity: VisualDensity(
                                horizontal: -4,
                                vertical: -4,
                              ),
                              activeColor: AppColor.buttonBG,
                              checkColor: Theme.of(context).primaryColor,
                              title: Text(
                                "Remember Me",
                                style: TextStyle(
                                  color: AppColor.text,
                                ),
                              ),
                              value: checkboxValue,
                              onChanged: (value) {
                                setState(() {
                                  checkboxValue = value!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                "/forgotPassword",
                              );
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      showDialog(
                        context: context,
                        builder: (builder) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            color: Theme.of(context).primaryColor,
                            backgroundColor: AppColor.buttonBG,
                          ),
                        ),
                      );

                      final resData = await LoginHttp().login(email, password);
                      if (resData["statusCode"] == 202) {
                        bool googleSignIn = await LogStatus().googleSignIn();
                        if (googleSignIn) {
                          await GoogleSingInApi.logout();
                          LogStatus().removeGoogleSignIn();
                        }

                        Navigator.pop(context);
                        if (checkboxValue) {
                          LogStatus().setToken(resData["body"]["token"]);
                        }
                        LogStatus.token = resData["body"]["token"];
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/home",
                          (route) => false,
                        );
                      } else {
                        Navigator.pop(context);

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
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
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
                height: 10,
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final user = await GoogleSingInApi.login();

                      if (user == null) {
                        await GoogleSingInApi.logout();
                        Message(
                          message: "Sign in failed.",
                          time: 3,
                          bgColor: Colors.red,
                          textColor: AppColor.onPrimary,
                        ).showMessage;
                        return;
                      }

                      showDialog(
                        context: context,
                        builder: (builder) => Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 6,
                            color: Theme.of(context).primaryColor,
                            backgroundColor: AppColor.buttonBG,
                          ),
                        ),
                      );

                      String? photoUrl = user.photoUrl;
                      photoUrl ??=
                          "https://res.cloudinary.com/gaurishankar/image/upload/v1658148482/ExpenseTracker/p3o8edl8jnwvdhk5xjmx.png";

                      final resData = await LoginHttp().googleSignIn(
                        UploadGoogleUser(
                          email: user.email,
                          profileName: user.displayName,
                          profilePicture: photoUrl,
                        ),
                      );

                      if (resData["statusCode"] == 202) {
                        Navigator.pop(context);
                        if (checkboxValue) {
                          LogStatus().setToken(resData["body"]["token"]);
                        }
                        LogStatus().setGoogleSignIn(true);
                        LogStatus.token = resData["body"]["token"];
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          "/home",
                          (route) => false,
                        );
                      }
                    } catch (error) {
                      return;
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 25,
                        width: 25,
                        fit: BoxFit.cover,
                        image: AssetImage("image/Google.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Login with google",
                          style: TextStyle(
                            color: AppColor.text,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      )
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.onPrimary,
                    padding: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    shadowColor: Colors.black45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account! ",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColor.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/register",
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 15,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
