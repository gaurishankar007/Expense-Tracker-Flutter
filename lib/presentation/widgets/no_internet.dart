import 'package:expense_tracker/config/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              FontAwesomeIcons.wifi,
              color: Theme.of(context).primaryColor,
              size: width * .4,
            ),
            Icon(
              FontAwesomeIcons.slash,
              color: Theme.of(context).primaryColor,
              size: width * .4,
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                "Please check your internet connection.",
                style: TextStyle(
                  fontSize: AppSize.h5["size"] - 6,
                  fontWeight: AppSize.h5["weight"],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
