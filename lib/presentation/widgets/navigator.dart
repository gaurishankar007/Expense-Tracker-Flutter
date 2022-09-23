import 'package:expense_tracker/config/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
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
              color: Theme.of(context).primaryColor,
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
            Navigator.pushNamed(
              context,
              "/home",
            );
          } else if (index == 1) {
            Navigator.pushNamed(
              context,
              "/income",
            );
          } else if (index == 2) {
            Navigator.pushNamed(
              context,
              "/expense",
            );
          } else if (index == 3) {
            Navigator.pushNamed(
              context,
              "/result",
            );
          }
        },
      ),
    );
  }
}
