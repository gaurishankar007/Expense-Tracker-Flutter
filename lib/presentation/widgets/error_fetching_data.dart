import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/themes/constant.dart';

class ErrorFetchingData extends StatelessWidget {
  const ErrorFetchingData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          FontAwesomeIcons.bug,
          color: Theme.of(context).primaryColor,
          size: 100,
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
                "Error occurred",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Text(
                "Fetching Data",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "This error occurred due server response data.",
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
