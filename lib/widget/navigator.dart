import 'package:expense_tracker/resource/colors.dart';
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
            color: AppColors.button,
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
              color: AppColors.iconHeading,
              size: 25,
            ),
            selectedIcon: Icon(
              Icons.home_filled,
              color: AppColors.primary,
              size: 25,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.circleDollarToSlot,
              color: AppColors.iconHeading,
              size: 25,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.circleDollarToSlot,
              color: AppColors.primary,
              size: 25,
            ),
            label: "Expense",
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.sackDollar,
              color: AppColors.iconHeading,
              size: 25,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.sackDollar,
              color: AppColors.primary,
              size: 25,
            ),
            label: "Income",
          ),
          NavigationDestination(
            icon: Icon(
              FontAwesomeIcons.chartLine,
              color: AppColors.iconHeading,
              size: 25,
            ),
            selectedIcon: Icon(
              FontAwesomeIcons.chartLine,
              color: AppColors.primary,
              size: 25,
            ),
            label: "Progress",
          ),
        ],
        height: 50,
        selectedIndex: pageIndex!,
        backgroundColor: AppColors.background,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
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
                builder: (builder) => Expense(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (builder) => Income(),
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
