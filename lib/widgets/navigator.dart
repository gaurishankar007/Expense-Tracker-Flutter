import 'package:expense_tracker/config/themes/constant.dart';
import 'package:expense_tracker/screen/expense/expense.dart';
import 'package:expense_tracker/screen/income/income.dart';
import 'package:expense_tracker/screen/progress/result.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screen/home.dart';

class PageNavigator extends StatelessWidget {
  final int? pageIndex;
  const PageNavigator({Key? key, @required this.pageIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.buttonBG,
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: NavigationBar(
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home_filled,
              color: AppColor.text,
              size: 25,
            ),
            selectedIcon: Icon(
              Icons.home_filled,
              color: AppColor.primary,
              size: 25,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.sackDollar,
              color: AppColor.text,
              size: 25,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.sackDollar,
              color: AppColor.primary,
              size: 25,
            ),
            label: "Income",
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.circleDollarToSlot,
              color: AppColor.text,
              size: 25,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.circleDollarToSlot,
              color: AppColor.primary,
              size: 25,
            ),
            label: "Expense",
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.chartLine,
              color: AppColor.text,
              size: 25,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.chartLine,
              color: AppColor.primary,
              size: 25,
            ),
            label: "Progress",
          ),
        ],
        height: 55,
        selectedIndex: pageIndex!,
        backgroundColor: AppColor.backgroundLight,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        onDestinationSelected: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => Home(),
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => IncomePage(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => ExpensePage(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => Result(),
              ),
            );
          }
        },
      ),
    );
  }
}
