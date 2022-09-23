import 'package:flutter/material.dart';

import '../../config/themes/constant.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  bool dataInsertion = false;
  bool dataVisualization = false;
  bool progressAndAchievement = false;
  bool dataPrivacy = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Help",
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
            color: AppColor.text,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: width * .03,
          right: width * .03,
          bottom: 20,
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
                height: 40,
                color: AppColor.backgroundLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data Insertion",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "How to insert income and expense data?",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.lightText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    AnimatedRotation(
                      turns: dataInsertion ? (90 / 360) : (270 / 360),
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.text,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            dataInsertion
                ? Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "1. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can AddIncomes and expenses daily.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image(
                        width: width * 0.4,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/help/AddIncome.png",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "2. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Name, amount and category should be given while adding an income or expense data.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image(
                        width: width * 0.4,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/help/AddExpense.png",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "3. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "There is no any limitation on how much incomes and expenses can be added daily.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  dataVisualization = !dataVisualization;
                });
              },
              child: Container(
                height: 40,
                color: AppColor.backgroundLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data Visualization",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "How data can be viewed with dates?",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.lightText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    AnimatedRotation(
                      turns: dataVisualization ? (90 / 360) : (270 / 360),
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.text,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            dataVisualization
                ? Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "1. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can visualize their daily, weekly, and monthly incomes and expenses detail.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image(
                        width: width * 0.4,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/help/Incomes.png",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "2. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can even search their expenses and incomes by giving start and end dates.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/SearchExpense.png",
                            ),
                          ),
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/SearchedExpense.png",
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
                            width: width * .04,
                            child: Text(
                              "3. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can view last and current month incomes and expense details with a bar chart in the home page with feedback message.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/BarChart.png",
                            ),
                          ),
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/Category.png",
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
                            width: width * .04,
                            child: Text(
                              "4. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can view their income and expense categories of the current month from high to low amount in the home page.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/IncomeCategory.png",
                            ),
                          ),
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/ExpenseCategory.png",
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
                            width: width * .04,
                            child: Text(
                              "5. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can also view the graph of the total expense amount of those days that they have inserted expenses in a month.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  progressAndAchievement = !progressAndAchievement;
                });
              },
              child: Container(
                height: 40,
                color: AppColor.backgroundLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Progress Point and Achievement",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "What is progress point and achievement?",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.lightText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    AnimatedRotation(
                      turns: progressAndAchievement ? (90 / 360) : (270 / 360),
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.text,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            progressAndAchievement
                ? Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "1. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users will get 15 progress points on adding an income and 10 progress point on adding an expense.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
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
                            width: width * .04,
                            child: Text(
                              "2. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can also unlock achievements and get even more progress points.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/ExpensePageCongratulation.png",
                            ),
                          ),
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/HomePageCongratulation.png",
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
                            width: width * .04,
                            child: Text(
                              "3. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can view their progress and achievements in the ProgressPage.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image(
                        width: width * 0.4,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/help/ProgressPage.png",
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "4. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Achievements are base on expenses and incomes. Their detail are provided on the AchievementPage. ",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/AchievementPage.png",
                            ),
                          ),
                          Image(
                            width: width * 0.4,
                            fit: BoxFit.fitWidth,
                            image: AssetImage(
                              "image/help/AchievementDetail.png",
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
                            width: width * .04,
                            child: Text(
                              "5. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users will have two kind of achievements. One is last month achievements which includes achievements got from the last month expenses and incomes and another is this month achievements which contains achievement got on the current month.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
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
                            width: width * .04,
                            child: Text(
                              "6. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "Users can also share their progress point and compete in the raking system.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Image(
                        width: width * 0.4,
                        fit: BoxFit.fitWidth,
                        image: AssetImage(
                          "image/help/RankingPage.png",
                        ),
                      ),
                    ],
                  )
                : SizedBox(),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  dataPrivacy = !dataPrivacy;
                });
              },
              child: Container(
                height: 40,
                color: AppColor.backgroundLight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Data Privacy",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "How users' data are protected?",
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColor.lightText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    AnimatedRotation(
                      turns: dataPrivacy ? (90 / 360) : (270 / 360),
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColor.text,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            dataPrivacy
                ? Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * .04,
                            child: Text(
                              "1. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "The expenses and incomes data of a user can be seen by the user only.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
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
                            width: width * .04,
                            child: Text(
                              "2. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "The users' data have not been shared with any other users and not used for any other purposes.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
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
                            width: width * .04,
                            child: Text(
                              "3. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "The rank page shows only those users' data who have shared their progress and achievements.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
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
                            width: width * .04,
                            child: Text(
                              "4. ",
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColor.lightText,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * .90,
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                text:
                                    "No one has been harmed intentionally by the use of this application.",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColor.lightText,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
