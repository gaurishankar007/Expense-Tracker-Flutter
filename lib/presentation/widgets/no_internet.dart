import 'package:expense_tracker/config/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Icon(
              FontAwesomeIcons.wifi,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
            Icon(
              FontAwesomeIcons.slash,
              color: Theme.of(context).primaryColor,
              size: 50,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "No Internet",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "Connection",
              style: TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please check your internet connection and try again",
              style: TextStyle(
                fontSize: AppSize.h5["size"] - 6,
                fontWeight: AppSize.h5["weight"],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            "Try Again",
          ),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 25,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
      ],
    );
  }
}
