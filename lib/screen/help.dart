import 'package:flutter/material.dart';

import '../resource/colors.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool dataInsertion = false;
  bool dataVisualization = false;
  bool dataPrivacy = false;

  @override
  Widget build(BuildContext context) {
    final sWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help",
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
            color: AppColors.iconHeading,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: sWidth * .03,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  dataInsertion = !dataInsertion;
                });
              },
              child: Container(
                height: 25,
                color: AppColors.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Data Insertion",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.iconHeading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotationTransition(
                      turns: dataInsertion
                          ? AlwaysStoppedAnimation(90 / 360)
                          : AlwaysStoppedAnimation(0 / 360),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.iconHeading,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  dataVisualization = !dataVisualization;
                });
              },
              child: Container(
                height: 25,
                color: AppColors.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Data Visualization",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.iconHeading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotationTransition(
                      turns: dataVisualization
                          ? AlwaysStoppedAnimation(90 / 360)
                          : AlwaysStoppedAnimation(0 / 360),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.iconHeading,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  dataPrivacy = !dataPrivacy;
                });
              },
              child: Container(
                height: 25,
                color: AppColors.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Data Privacy",
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.iconHeading,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    RotationTransition(
                      turns: dataPrivacy
                          ? AlwaysStoppedAnimation(90 / 360)
                          : AlwaysStoppedAnimation(0 / 360),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.iconHeading,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: sWidth * .04,
                      child: Text(
                        "1. ",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sWidth * .90,
                      child: RichText(
                        text: TextSpan(
                          text:
                              "The expenses and incomes data of a user can be seen by the user only.",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: sWidth * .04,
                      child: Text(
                        "2. ",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sWidth * .90,
                      child: RichText(
                        text: TextSpan(
                          text:
                              "The users' data have not been shared with any other users and not used for any other purposes.",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: sWidth * .04,
                      child: Text(
                        "3. ",
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.text,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sWidth * .90,
                      child: RichText(
                        text: TextSpan(
                          text:
                              "The rank page shows only those users' data who have shared their progress and achievements.",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
