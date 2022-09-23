import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../data/remote/token_http.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';

class VerifyToken extends StatefulWidget {
  final String? userId;
  const VerifyToken({Key? key, @required this.userId}) : super(key: key);

  @override
  State<VerifyToken> createState() => _VerifyTokenState();
}

class _VerifyTokenState extends State<VerifyToken> {
  final _formKey = GlobalKey<FormState>();
  String token = "";
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
          "Verify Token",
          style: TextStyle(
            color: AppColor.text,
            fontSize: 18,
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key("Token"),
                  onSaved: (value) {
                    token = value!;
                  },
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    MultiValidator([
                      RequiredValidator(errorText: "Token is required!"),
                    ]);
                    return null;
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: AppColor.buttonBG,
                    hintText: "Enter the token.....",
                    hintStyle: TextStyle(
                      color: AppColor.textLight,
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

                        final resData = await TokenHttp()
                            .verifyToken(token, widget.userId!);

                        if (resData["statusCode"] == 200) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            "/",
                            (route) => false,
                          );

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
                      "Reset Password",
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
