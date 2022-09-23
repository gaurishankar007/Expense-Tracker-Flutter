import 'package:expense_tracker/config/category.dart';
import 'package:expense_tracker/core/resources/internet_check.dart';
import 'package:expense_tracker/presentation/blocs/home/home_bloc.dart';
import 'package:expense_tracker/presentation/widgets/no_internet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../config/themes/constant.dart';
import '../../data/model/expense_model.dart';
import '../../data/model/home_model.dart';
import '../../data/model/income_model.dart';
import '../widgets/navigator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<HomeData> userHomeData;
  bool moreExpense = false;
  bool moreIncome = false;
  List<String> expenseCategories = [];
  List<String> incomeCategories = [];

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => HomeBloc(
          // RepositoryProvider.of<HomeData>(context),
          // RepositoryProvider.of<CheckInternet>(context)
          )
        ..add(HomeLoadedEvent()),
      child: WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: ((context, state) {
                  List<Widget> children = [];
                  if (state is NoInternetState) {
                    children = [NoInternet()];
                  }
                  if (state is HomeLoadingState) {
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
                  }
                  if (state is HomeLoadedState) {
                    children = <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.greeting,
                              style: TextStyle(
                                color: AppColor.text,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              constraints: BoxConstraints(),
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.settings,
                                color: AppColor.text,
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  "/setting",
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      barChart(
                        context,
                        state.homeData.thisMonthView!,
                        state.homeData.thisMonthExpenseAmount!,
                        state.homeData.thisMonthIncomeAmount!,
                        state.homeData.previousMonthExpenseAmount!,
                        state.homeData.previousMonthIncomeAmount!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      feedback(context, state.homeData),
                      SizedBox(
                        height: 5,
                      ),
                      incomeDetail(
                        context,
                        state.homeData.thisMonthIncomeCategories!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      expenseDetail(
                        context,
                        state.homeData.thisMonthExpenseCategories!,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      state.homeData.expenseDays!.length > 2
                          ? expenseLineChart(
                              context,
                              state.homeData.thisMonthView!,
                              state.homeData.expenseDays!,
                              state.homeData.expenseAmounts!,
                              state.homeData.maxExpenseAmount!,
                            )
                          : SizedBox(),
                    ];
                  }

                  return Column(
                    children: children,
                  );
                }),
              ),
            ),
          ),
          bottomNavigationBar: PageNavigator(pageIndex: 0),
        ),
      ),
    );
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App?'),
            content: Text('Do you want to exit Expense Tracker'),
            actions: [
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false; //if showDialogue had returned null, then return false
  }

  Widget congratulation(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColor.backgroundLight,
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.all(10),
      children: [
        Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  "image/Congratulation.png",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "New Achievement Unlocked.",
              style: TextStyle(
                color: AppColor.text,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size.zero,
                padding: EdgeInsets.all(8),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                  context,
                  "/result",
                );
              },
              child: Text("Check Out"),
            ),
          ],
        ),
      ],
    );
  }

  Widget barChart(
    BuildContext context,
    bool thisMonthView,
    int thisMonthExpenseAmount,
    int thisMonthIncomeAmount,
    int previousMonthExpenseAmount,
    int previousMonthIncomeAmount,
  ) {
    if (thisMonthExpenseAmount == 0 &&
        thisMonthIncomeAmount == 0 &&
        previousMonthExpenseAmount == 0 &&
        previousMonthIncomeAmount == 0) {
      return SizedBox();
    }

    final width = MediaQuery.of(context).size.width;
    const Color leftBarColor = Colors.orange;
    Color rightBarColor = Theme.of(context).primaryColor;
    double barWidth = width * .16;
    const BorderRadius borderRadius = BorderRadius.only(
      topLeft: Radius.circular(5),
      topRight: Radius.circular(5),
      bottomLeft: Radius.circular(0),
      bottomRight: Radius.circular(0),
    );

    List<int> amounts = [
      thisMonthExpenseAmount,
      thisMonthIncomeAmount,
      previousMonthExpenseAmount,
      previousMonthIncomeAmount
    ];
    amounts.sort();
    int maxAmount = amounts.last + amounts.last ~/ 10;

    List<BarChartGroupData> showingBarGroups = [];
    List<BarChartRodData> thisMonthBarRods = [];
    List<BarChartRodData> previousMonthBarRods = [];

    if (thisMonthIncomeAmount != 0) {
      thisMonthBarRods.add(BarChartRodData(
        borderRadius: borderRadius,
        toY: (thisMonthIncomeAmount / maxAmount) * 5,
        color: rightBarColor,
        width: barWidth,
      ));
    }
    if (thisMonthExpenseAmount != 0) {
      thisMonthBarRods.add(BarChartRodData(
        borderRadius: borderRadius,
        toY: (thisMonthExpenseAmount / maxAmount) * 5,
        color: leftBarColor,
        width: barWidth,
      ));
    }
    if (previousMonthIncomeAmount != 0) {
      previousMonthBarRods.add(BarChartRodData(
        borderRadius: borderRadius,
        toY: (previousMonthIncomeAmount / maxAmount) * 5,
        color: rightBarColor,
        width: barWidth,
      ));
    }
    if (previousMonthExpenseAmount != 0) {
      previousMonthBarRods.add(BarChartRodData(
        borderRadius: borderRadius,
        toY: (previousMonthExpenseAmount / maxAmount) * 5,
        color: leftBarColor,
        width: barWidth,
      ));
    }
    if (thisMonthBarRods.isNotEmpty) {
      showingBarGroups.add(BarChartGroupData(
        barsSpace: 5,
        x: 0,
        barRods: thisMonthBarRods,
      ));
    }
    if (previousMonthBarRods.isNotEmpty) {
      showingBarGroups.add(BarChartGroupData(
        barsSpace: 5,
        x: 1,
        barRods: previousMonthBarRods,
      ));
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Income",
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 10,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.orange,
                      radius: 5,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: "Expense",
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 200,
          width: width * .94,
          child: BarChart(
            BarChartData(
              maxY: 5,
              barTouchData: BarTouchData(
                touchTooltipData: BarTouchTooltipData(
                  tooltipBgColor: Theme.of(context).primaryColor,
                  tooltipMargin: 25,
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    return BarTooltipItem(
                      "Rs." + (((rod.toY / 5) * maxAmount).round()).toString(),
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                touchCallback: (FlTouchEvent event, barTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        barTouchResponse == null ||
                        barTouchResponse.spot == null) {
                      touchedGroupIndex = -1;
                      return;
                    }
                    touchedGroupIndex =
                        barTouchResponse.spot!.touchedBarGroupIndex;
                  });
                },
              ),
              gridData: FlGridData(
                show: false,
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 20,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      List<String> titles = ["This Month", "Last Month"];

                      Widget text = Text(
                        titles[value.toInt()],
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      );

                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 5, //margin top
                        child: text,
                      );
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: maxAmount > 100000
                        ? 40
                        : maxAmount > 10000
                            ? 35
                            : 25,
                    interval: 1,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      TextStyle style = TextStyle(
                        color: AppColor.text,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      );
                      String text;

                      String amount1 = (maxAmount / 5000) > 0.1
                          ? (maxAmount / 5000).toStringAsFixed(1) + "k"
                          : (maxAmount / 5000).toStringAsFixed(2) + "k";
                      String amount2 = ((maxAmount / 5000) * 2) > 0.1
                          ? ((maxAmount / 5000) * 2).toStringAsFixed(1) + "k"
                          : ((maxAmount / 5000) * 2).toStringAsFixed(2) + "k";
                      String amount3 = ((maxAmount / 5000) * 3) > 0.1
                          ? ((maxAmount / 5000) * 3).toStringAsFixed(1) + "k"
                          : ((maxAmount / 5000) * 3).toStringAsFixed(2) + "k";
                      String amount4 = ((maxAmount / 5000) * 4) > 0.1
                          ? ((maxAmount / 5000) * 4).toStringAsFixed(1) + "k"
                          : ((maxAmount / 5000) * 4).toStringAsFixed(2) + "k";
                      String amount5 = (maxAmount / 1000) > 0.1
                          ? (maxAmount / 1000).toStringAsFixed(1) + "k"
                          : (maxAmount / 1000).toStringAsFixed(2) + "k";

                      if (value.toInt() == 1) {
                        text = amount1;
                      } else if (value.toInt() == 2) {
                        text = amount2;
                      } else if (value.toInt() == 3) {
                        text = amount3;
                      } else if (value.toInt() == 4) {
                        text = amount4;
                      } else if (value.toInt() == 5) {
                        text = amount5;
                      } else {
                        text = "";
                      }

                      return SideTitleWidget(
                        axisSide: meta.axisSide,
                        space: 5,
                        child: Text(text, style: style),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.text,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: AppColor.text,
                    width: 2,
                  ),
                  right: BorderSide(color: Colors.transparent),
                  top: BorderSide(color: Colors.transparent),
                ),
              ),
              barGroups: showingBarGroups,
            ),
          ),
        ),
      ],
    );
  }

  Widget feedback(BuildContext context, HomeData homeData) {
    final width = MediaQuery.of(context).size.width;

    if (homeData.thisMonthExpenseAmount! == 0 &&
        homeData.thisMonthIncomeAmount! == 0) {
      return SizedBox();
    }

    bool isPadding = false;
    if (homeData.thisMonthExpenseAmount! > homeData.thisMonthIncomeAmount! &&
        homeData.thisMonthIncomeAmount != 0) {
      isPadding = true;
    }
    if (homeData.previousMonthExpenseAmount! != 0 &&
        homeData.thisMonthExpenseAmount! >
            homeData.previousMonthExpenseAmount!) {
      isPadding = true;
    }

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        right: width * 0.03,
        left: width * 0.03,
      ),
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          homeData.thisMonthExpenseAmount! > homeData.thisMonthIncomeAmount! &&
                  homeData.thisMonthIncomeAmount != 0
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    width: width * .94,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.onPrimary,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * .14,
                          child: Icon(
                            FontAwesomeIcons.faceSadTear,
                            color: Colors.deepOrange,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: width * .8 - 20,
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text:
                                  "This month expenses looks bad. Save money.",
                              style: TextStyle(
                                color: AppColor.text,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : homeData.previousMonthExpenseAmount! != 0 &&
                      homeData.thisMonthExpenseAmount! >
                          homeData.previousMonthExpenseAmount!
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Container(
                        width: width * .94,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColor.onPrimary,
                          borderRadius: BorderRadius.circular(
                            5,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: width * .14,
                              child: Icon(
                                FontAwesomeIcons.faceSurprise,
                                color: Colors.orange,
                                size: 40,
                              ),
                            ),
                            SizedBox(
                              width: width * .8 - 20,
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  text:
                                      "Last month expense was less than this month.",
                                  style: TextStyle(
                                    color: AppColor.text,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
          homeData.thisMonthExpenseAmount! < homeData.thisMonthIncomeAmount! &&
                  homeData.thisMonthExpenseAmount != 0
              ? Padding(
                  padding: EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    left: isPadding ? 20 : 0,
                  ),
                  child: Container(
                    width: width * .94,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColor.onPrimary,
                      borderRadius: BorderRadius.circular(
                        5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * .14,
                          child: Icon(
                            FontAwesomeIcons.faceSmileBeam,
                            color: Theme.of(context).primaryColor,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: width * .8 - 20,
                          child: RichText(
                            textAlign: TextAlign.justify,
                            text: TextSpan(
                              text:
                                  "This month expenses looks good. Keep it up.",
                              style: TextStyle(
                                color: AppColor.text,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget incomeDetail(BuildContext context, List<IncomeCategorized> category) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Income Categories",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              category.isNotEmpty
                  ? TextButton.icon(
                      onPressed: () {
                        if (moreIncome) {
                          List<String> tempCategory = category
                              .asMap()
                              .map((key, value) {
                                return MapEntry(key, category[key].category!);
                              })
                              .values
                              .toList();

                          setState(() {
                            incomeCategories = tempCategory;
                            moreIncome = !moreIncome;
                          });
                        } else {
                          List<String> tempCategory = incomeCategories;
                          for (int i = 0;
                              i < Category.incomeCategory.length;
                              i++) {
                            if (!tempCategory
                                .contains(Category.incomeCategory[i])) {
                              tempCategory.add(Category.incomeCategory[i]);
                            }
                          }
                          setState(() {
                            incomeCategories = tempCategory;
                            moreIncome = !moreIncome;
                          });
                        }
                      },
                      icon: AnimatedRotation(
                        turns: moreIncome ? (90 / 360) : (270 / 360),
                        duration: Duration(milliseconds: 500),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColor.text,
                          size: 18,
                        ),
                      ),
                      label: Text(
                        moreIncome ? "Less" : "More",
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: (width - (width * .53)) / (width * .58),
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            crossAxisCount: 4,
            children: List.generate(
              incomeCategories.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/categorizedIncome",
                      arguments: incomeCategories[index],
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.onPrimary,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image(
                            height: width * 0.2,
                            width: width * 0.2,
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "image/category/${incomeCategories[index]}.jpg",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        incomeCategories[index],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseDetail(
      BuildContext context, List<ExpenseCategorized> category) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.03,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Expense Categories",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
              category.isNotEmpty
                  ? TextButton.icon(
                      onPressed: () {
                        if (moreExpense) {
                          List<String> tempCategory = category
                              .asMap()
                              .map((key, value) {
                                return MapEntry(key, category[key].category!);
                              })
                              .values
                              .toList();

                          setState(() {
                            expenseCategories = tempCategory;
                            moreExpense = !moreExpense;
                          });
                        } else {
                          List<String> tempCategory = expenseCategories;
                          for (int i = 0;
                              i < Category.expenseCategory.length;
                              i++) {
                            if (!tempCategory
                                .contains(Category.expenseCategory[i])) {
                              tempCategory.add(Category.expenseCategory[i]);
                            }
                          }
                          setState(() {
                            expenseCategories = tempCategory;
                            moreExpense = !moreExpense;
                          });
                        }
                      },
                      icon: AnimatedRotation(
                        turns: moreExpense ? (90 / 360) : (270 / 360),
                        duration: Duration(milliseconds: 500),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColor.text,
                          size: 18,
                        ),
                      ),
                      label: Text(
                        moreExpense ? "Less" : "More",
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          GridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            childAspectRatio: (width - (width * .53)) / (width * .58),
            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            crossAxisCount: 4,
            children: List.generate(
              expenseCategories.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/categorizedExpense",
                      arguments: expenseCategories[index],
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.onPrimary,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(2, 2),
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image(
                            height: width * 0.2,
                            width: width * 0.2,
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "image/category/${expenseCategories[index]}.jpg",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        expenseCategories[index],
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget expenseLineChart(BuildContext context, bool thisMonthView,
      List<int> expenseDays, List<int> expenseAmounts, int maxExpenseAmount) {
    final width = MediaQuery.of(context).size.width;
    List<FlSpot> expenseLineData = [];
    List<int> tempExpenseDays = [];

    for (int i = 1; i < expenseDays.length + 1; i++) {
      tempExpenseDays.add(i);
    }

    int maxAmount = maxExpenseAmount + maxExpenseAmount ~/ 5;

    for (int i = 0; i < expenseDays.length; i++) {
      expenseLineData.add(FlSpot(
          tempExpenseDays[i].toDouble(), (expenseAmounts[i] / maxAmount) * 5));
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: width * 0.03,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                thisMonthView
                    ? "This" " Month Expenses"
                    : "Last" " Month Expenses",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 200,
            width: width * .98,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  handleBuiltInTouches: true,
                  touchTooltipData: LineTouchTooltipData(
                      tooltipBgColor: Theme.of(context).primaryColor,
                      tooltipMargin: 50,
                      tooltipRoundedRadius: 5,
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final flSpot = barSpot;
                          if (flSpot.x == 0 || flSpot.x == 6) {
                            return null;
                          }

                          return LineTooltipItem(
                            "Rs. ${((flSpot.y / 5) * maxAmount).round()}",
                            const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList();
                      }),
                ),
                gridData: FlGridData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      reservedSize: maxAmount > 100000
                          ? 40
                          : maxAmount > 10000
                              ? 35
                              : 28,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        TextStyle style = TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        );
                        String text = "";
                        String amount1 = (maxAmount / 5000) > 0.1
                            ? (maxAmount / 5000).toStringAsFixed(1) + "k"
                            : (maxAmount / 5000).toStringAsFixed(2) + "k";
                        String amount2 = ((maxAmount / 5000) * 2) > 0.1
                            ? ((maxAmount / 5000) * 2).toStringAsFixed(1) + "k"
                            : ((maxAmount / 5000) * 2).toStringAsFixed(2) + "k";
                        String amount3 = ((maxAmount / 5000) * 3) > 0.1
                            ? ((maxAmount / 5000) * 3).toStringAsFixed(1) + "k"
                            : ((maxAmount / 5000) * 3).toStringAsFixed(2) + "k";
                        String amount4 = ((maxAmount / 5000) * 4) > 0.1
                            ? ((maxAmount / 5000) * 4).toStringAsFixed(1) + "k"
                            : ((maxAmount / 5000) * 4).toStringAsFixed(2) + "k";
                        String amount5 = (maxAmount / 1000) > 0.1
                            ? (maxAmount / 1000).toStringAsFixed(1) + "k"
                            : (maxAmount / 1000).toStringAsFixed(2) + "k";

                        if (value.toInt() == 1) {
                          text = amount1;
                        } else if (value.toInt() == 2) {
                          text = amount2;
                        } else if (value.toInt() == 3) {
                          text = amount3;
                        } else if (value.toInt() == 4) {
                          text = amount4;
                        } else if (value.toInt() == 5) {
                          text = amount5;
                        }

                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 5,
                          child: Text(
                            text,
                            style: style,
                            textAlign: TextAlign.center,
                          ),
                        );
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameWidget: Text(
                      "Date",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 18,
                      interval: 1,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        TextStyle style = TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                          fontSize: expenseDays.length > 12
                              ? expenseDays.length > 20
                                  ? 7
                                  : 9
                              : 10,
                        );
                        Widget text = Text("");

                        for (int i = 1; i < expenseDays.length + 1; i++) {
                          if (value.toInt() == i) {
                            text = Text(expenseDays[i - 1].toString(),
                                style: style);
                          }
                        }

                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 5,
                          child: text,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: AppColor.text,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: AppColor.text,
                      width: 2,
                    ),
                    right: BorderSide(color: Colors.transparent),
                    top: BorderSide(color: Colors.transparent),
                  ),
                ),
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: Colors.orange,
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Color(0xFFF8B44F),
                    ),
                    spots: expenseLineData,
                  ),
                ],
                minX: 0,
                maxX: expenseDays.length + 1,
                maxY: 5,
                minY: 0,
              ),
              swapAnimationDuration: const Duration(milliseconds: 250),
            ),
          ),
        ],
      ),
    );
  }
}
