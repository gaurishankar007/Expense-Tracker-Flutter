import 'package:expense_tracker/data/remote/progress_http.dart';
import 'package:expense_tracker/presentation/widgets/navigator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config/themes/constant.dart';
import '../../../data/model/progress_model.dart';

class RankingSystem extends StatefulWidget {
  const RankingSystem({Key? key}) : super(key: key);

  @override
  State<RankingSystem> createState() => _RankingSystemState();
}

class _RankingSystemState extends State<RankingSystem> {
  late Future<TopProgress> usersProgress;
  List<Progress> progressPoints = [];
  List<Progress> tmpPoints = [];
  List<Progress> pmpPoints = [];
  List<Progress> progressList = [];
  List<String> pointList = [];
  int progressIndex = 0;

  void topUsersProgress() {
    usersProgress = ProgressHttp().topUsersProgress();
    usersProgress.then((value) {
      progressPoints = value.progressPoints!;
      tmpPoints = value.tmpPoints!;
      pmpPoints = value.pmpPoints!;
      progressList = value.progressPoints!;

      for (int i = 0; i < progressList.length; i++) {
        String point = "";
        point = progressList[i].progress! > 1000
            ? (progressList[i].progress! / 1000).toStringAsFixed(1) + " K"
            : progressList[i].progress!.toString();
        pointList.add(point);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    topUsersProgress();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: AppColor.text,
          ),
        ),
        title: Text(
          "Progress Point Ranking",
          style: TextStyle(
            color: AppColor.text,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          right: width * 0.03,
          left: width * 0.03,
          bottom: 10,
        ),
        child: FutureBuilder<TopProgress>(
          future: usersProgress,
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
              children = <Widget>[
                getButtons(context),
                SizedBox(
                  height: 10,
                ),
                rankedUsers(context),
              ];
              if (snapshot.hasData) {
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
      bottomNavigationBar: PageNavigator(
        pageIndex: 3,
      ),
    );
  }

  Widget getButtons(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * .30,
          child: ElevatedButton(
            onPressed: () {
              if (progressIndex == 0) {
                return;
              }

              List<String> tempPoints = [];

              for (int i = 0; i < progressPoints.length; i++) {
                String point = "";
                point = progressPoints[i].progress! > 1000
                    ? (progressPoints[i].progress! / 1000).toStringAsFixed(1) +
                        " K"
                    : progressPoints[i].progress!.toString();
                tempPoints.add(point);
              }

              setState(() {
                progressList = progressPoints;
                pointList = tempPoints;
                progressIndex = 0;
              });
            },
            child: Text(
              "Total",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: progressIndex == 0
                  ? Theme.of(context).primaryColor
                  : AppColor.buttonBG,
              foregroundColor:
                  progressIndex == 0 ? AppColor.onPrimary : AppColor.text,
              minimumSize: Size.zero,
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * .30,
          child: ElevatedButton(
            onPressed: () {
              if (progressIndex == 1) {
                return;
              }

              List<String> tempPoints = [];

              for (int i = 0; i < tmpPoints.length; i++) {
                String point = "";
                point = tmpPoints[i].tmp! > 1000
                    ? (tmpPoints[i].tmp! / 1000).toStringAsFixed(1) + " K"
                    : tmpPoints[i].tmp!.toString();
                tempPoints.add(point);
              }

              setState(() {
                progressList = tmpPoints;
                pointList = tempPoints;
                progressIndex = 1;
              });
            },
            child: Text(
              "This Month",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: progressIndex == 1
                  ? Theme.of(context).primaryColor
                  : AppColor.buttonBG,
              foregroundColor:
                  progressIndex == 1 ? AppColor.onPrimary : AppColor.text,
              minimumSize: Size.zero,
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
        SizedBox(
          width: width * .30,
          child: ElevatedButton(
            onPressed: () {
              if (progressIndex == 2) {
                return;
              }

              List<String> tempPoints = [];

              for (int i = 0; i < pmpPoints.length; i++) {
                String point = "";
                point = pmpPoints[i].pmp! > 1000
                    ? (pmpPoints[i].pmp! / 1000).toStringAsFixed(1) + " K"
                    : pmpPoints[i].pmp!.toString();
                tempPoints.add(point);
              }

              setState(() {
                progressList = pmpPoints;
                pointList = tempPoints;
                progressIndex = 2;
              });
            },
            child: Text(
              "Last Month",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: progressIndex == 2
                  ? Theme.of(context).primaryColor
                  : AppColor.buttonBG,
              foregroundColor:
                  progressIndex == 2 ? AppColor.onPrimary : AppColor.text,
              minimumSize: Size.zero,
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget rankedUsers(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Color color = Colors.black54;
    if (progressIndex == 0) {
      color = Theme.of(context).primaryColor;
    } else if (progressIndex == 1) {
      color = Colors.green;
    } else if (progressIndex == 2) {
      color = Colors.orange;
    }

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: progressList.length,
      itemBuilder: ((context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    (index + 1).toString() + ".",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColor.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: AppColor.form,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(
                        height: 40,
                        width: 40,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            progressList[index].user!.profilePicture!),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: width * .4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          progressList[index].user!.profileName!,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.text,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            IconButton(
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (progressList[index]
                                    .newAchievement!
                                    .isEmpty) {
                                  return;
                                }
                                showDialog(
                                  context: context,
                                  builder: (builder) => userAchievements(
                                    context,
                                    "New Achievements",
                                    progressList[index].newAchievement!,
                                  ),
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.medal,
                                size: 16,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              progressList[index]
                                      .newAchievement!
                                      .length
                                      .toString() +
                                  ",",
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.text,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            IconButton(
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (progressList[index]
                                    .oldAchievement!
                                    .isEmpty) {
                                  return;
                                }
                                showDialog(
                                  context: context,
                                  builder: (builder) => userAchievements(
                                    context,
                                    "Old Achievements",
                                    progressList[index].oldAchievement!,
                                  ),
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.medal,
                                size: 16,
                                color: Colors.orange,
                              ),
                            ),
                            Text(
                              progressList[index]
                                  .oldAchievement!
                                  .length
                                  .toString(),
                              textAlign: TextAlign.justify,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColor.text,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(32.5),
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
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: AppColor.onPrimary,
                      borderRadius: BorderRadius.circular(27.5),
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
                        text: pointList[index],
                        style: TextStyle(
                          color: AppColor.text,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget userAchievements(BuildContext context, String achievementType,
      List<Achievement> achievements) {
    final width = MediaQuery.of(context).size.width;

    return SimpleDialog(
      backgroundColor: AppColor.backgroundLight,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      children: [
        SizedBox(
          height: achievements.length <= 2 ? width * .4 : width * .5,
          width: width * .5,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  achievementType,
                  style: TextStyle(
                    color: AppColor.text,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: (width - (width * .53)) / (width * .43),
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  children: List.generate(
                    achievements.length,
                    (index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image(
                              width: width * 0.25,
                              fit: BoxFit.fitWidth,
                              image: AssetImage(
                                "image/achievement/" +
                                    achievements[index].name! +
                                    ".png",
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            achievements[index].name!,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            style: TextStyle(
                              color: AppColor.text,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
