import 'package:expense_tracker/data/remote/progress_http.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/themes/constant.dart';
import '../../../data/model/progress_model.dart';
import '../../widgets/navigator.dart';

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  late Future<ProgressData> userProgress;

  void loadProgress() {
    userProgress = ProgressHttp().getUserProgress();
  }

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 10,
            right: width * 0.03,
            bottom: 40,
            left: width * 0.03,
          ),
          child: FutureBuilder<ProgressData>(
            future: userProgress,
            builder: ((context, snapshot) {
              List<Widget> children = [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                children = <Widget>[
                  Container(
                    width: width,
                    height: height,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                      color: Theme.of(context).primaryColor,
                      backgroundColor: AppColor.buttonBG,
                    ),
                  )
                ];
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  children = <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(
                                snapshot.data!.progress!.user!.profilePicture!,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Your Progress",
                              style: TextStyle(
                                color: AppColor.text,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  "/rankingSystem",
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.rankingStar,
                                color: AppColor.text,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    progressPoints(
                      context,
                      snapshot.data!.progress!.progress!,
                      snapshot.data!.progress!.pmp!,
                      snapshot.data!.progress!.tmp!,
                    ),
                    thisMonthAchievements(
                      context,
                      snapshot.data!.progress!.newAchievement!,
                    ),
                    previousMonthAchievements(
                      context,
                      snapshot.data!.progress!.oldAchievement!,
                    ),
                  ];
                } else if (snapshot.hasError) {
                  if ("${snapshot.error}".split("Exception: ")[0] == "Socket") {
                    children = <Widget>[
                      Container(
                        width: width,
                        height: height,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.warning_rounded,
                              size: 25,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Connection Problem",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ];
                  } else {
                    children = <Widget>[
                      Container(
                        width: width,
                        height: height,
                        alignment: Alignment.center,
                        child: Text(
                          "${snapshot.error}",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      )
                    ];
                  }
                }
              }

              return Column(
                children: children,
              );
            }),
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/achievement",
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            FontAwesomeIcons.medal,
            size: 20,
          ),
        ),
      ),
      bottomNavigationBar: PageNavigator(pageIndex: 3),
    );
  }

  Widget progressPoints(
      BuildContext context, int progress1, int pmp1, int tmp1) {
    final width = MediaQuery.of(context).size.width;

    String progress = progress1 > 1000
        ? (progress1 / 1000).toStringAsFixed(1) + " K"
        : progress1.toString();

    String pmp =
        pmp1 > 1000 ? (pmp1 / 1000).toStringAsFixed(1) + " K" : pmp1.toString();

    String tmp =
        tmp1 > 1000 ? (tmp1 / 1000).toStringAsFixed(1) + " K" : tmp1.toString();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: width * .28,
                  height: width * .28,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(width * .14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 5,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: width * .25,
                  height: width * .25,
                  decoration: BoxDecoration(
                    color: AppColor.onPrimary,
                    borderRadius: BorderRadius.circular(width * .125),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: pmp,
                      style: TextStyle(
                        color: AppColor.text,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text: "Last Month",
                style: TextStyle(
                  color: AppColor.text,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: width * .32,
                  height: width * .32,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(width * .16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 5,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: width * .29,
                  height: width * .29,
                  decoration: BoxDecoration(
                    color: AppColor.onPrimary,
                    borderRadius: BorderRadius.circular(width * .145),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: progress,
                      style: TextStyle(
                        color: AppColor.text,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text: "Total",
                style: TextStyle(
                  color: AppColor.text,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: width * .28,
                  height: width * .28,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(width * .14),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 2,
                        blurRadius: 5,
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  width: width * .25,
                  height: width * .25,
                  decoration: BoxDecoration(
                    color: AppColor.onPrimary,
                    borderRadius: BorderRadius.circular(width * .125),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: tmp,
                      style: TextStyle(
                        color: AppColor.text,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            RichText(
              text: TextSpan(
                text: "This Month",
                style: TextStyle(
                  color: AppColor.text,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget thisMonthAchievements(
      BuildContext context, List<Achievement> newAchievements) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (newAchievements.isEmpty) {
      return SizedBox();
    }

    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "This Month Achievements",
            style: TextStyle(
              fontSize: 18,
              color: AppColor.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: (width - (width * .53)) / (height * .24),
            crossAxisSpacing: 5,
            crossAxisCount: 2,
            children: List.generate(
              newAchievements.length,
              (index) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        height: height * 0.17,
                        width: width * 0.4,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/achievement/" +
                              newAchievements[index].name! +
                              ".png",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      newAchievements[index].name!,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget previousMonthAchievements(
      BuildContext context, List<Achievement> oldAchievements) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    if (oldAchievements.isEmpty) {
      return SizedBox();
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Last Month Achievements",
            style: TextStyle(
              fontSize: 18,
              color: AppColor.text,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: (width - (width * .53)) / (height * .24),
            crossAxisSpacing: 5,
            crossAxisCount: 2,
            children: List.generate(
              oldAchievements.length,
              (index) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        height: height * 0.17,
                        width: width * 0.4,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/achievement/" +
                              oldAchievements[index].name! +
                              ".png",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      oldAchievements[index].name!,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
