import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import '../../../data/model/income_model.dart';
import '../../../data/remote/income_http.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';
import '../../widgets/navigator.dart';

class CategorizedIncome extends StatefulWidget {
  final String? category;
  const CategorizedIncome({Key? key, @required this.category})
      : super(key: key);

  @override
  State<CategorizedIncome> createState() => _CategorizedIncomeState();
}

class _CategorizedIncomeState extends State<CategorizedIncome> {
  late Future<List<IncomeData>> incomeCategories;
  late List<IncomeData> incomeList;
  String firstDate = "";
  int incomeAmount = 0;
  int incomeIndex = 0;

  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColor.buttonBG,
      width: 2,
      style: BorderStyle.solid,
    ),
  );

  void getCategorizedIncomes() async {
    int tempIncomeAmount = 0;
    incomeCategories = IncomeHttp().getCategorizedIncome(widget.category!);
    incomeCategories.then((value) {
      for (int i = 0; i < value.length; i++) {
        tempIncomeAmount = tempIncomeAmount + value[i].amount!;
      }
      setState(() {
        incomeList = value;
        incomeAmount = tempIncomeAmount;
      });
    });

    firstDate = await IncomeHttp().getCategoryStartDate(widget.category!);
  }

  @override
  void initState() {
    super.initState();
    getCategorizedIncomes();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<IncomeData>>(
            future: incomeCategories,
            builder: (context, snapshot) {
              List<Widget> children = [];
              if (snapshot.connectionState == ConnectionState.waiting) {
                children = <Widget>[
                  Container(
                    width: width * 0.97,
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
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  child: Image(
                                    width: width,
                                    height: height * .3,
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      "image/category/${widget.category}.jpg",
                                    ),
                                  ),
                                ),
                                Container(
                                  width: width,
                                  height: height * .3,
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black38,
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.015,
                                vertical: 5,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  text:
                                      "${widget.category} (Rs. $incomeAmount)",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColor.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        IconButton(
                          padding: EdgeInsets.all(5.0),
                          constraints: BoxConstraints(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_outlined,
                            color: AppColor.onPrimary,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                    viewIncomes(context),
                    SizedBox(
                      height: 100,
                    ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Container(
                      width: width * 0.97,
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

              return Column(
                children: children,
              );
            },
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        height: 110,
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                if (incomeIndex == 0) {
                  return;
                }

                List<IncomeData> tempIncomeList =
                    await IncomeHttp().getCategorizedIncome(widget.category!);
                int tempIncomeAmount = 0;
                for (int i = 0; i < tempIncomeList.length; i++) {
                  tempIncomeAmount =
                      tempIncomeAmount + tempIncomeList[i].amount!;
                }

                setState(() {
                  incomeList = tempIncomeList;
                  incomeAmount = tempIncomeAmount;
                  incomeIndex = 0;
                });
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: incomeIndex == 0
                      ? Theme.of(context).primaryColor
                      : AppColor.onPrimary,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.buttonBG,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 5),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.date_range_rounded,
                  color: incomeIndex == 0
                      ? AppColor.onPrimary
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    incomeList = [];
                    incomeAmount = 0;
                    incomeIndex = 1;
                  });

                  showDialog(
                    context: context,
                    builder: (builder) => selectDate(context, firstDate),
                  );
                },
                backgroundColor: incomeIndex == 1
                    ? Theme.of(context).primaryColor
                    : AppColor.onPrimary,
                child: Icon(
                  Icons.search_rounded,
                  color: incomeIndex == 1
                      ? AppColor.onPrimary
                      : Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: PageNavigator(pageIndex: 0),
    );
  }

  Widget selectDate(BuildContext context, String firstDate) {
    String startDate = "", endDate = "";

    return StatefulBuilder(builder: (context, setState1) {
      return SimpleDialog(
        backgroundColor: AppColor.backgroundLight,
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.only(
              top: 5,
              left: 15,
              right: 15,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    DateTimeField(
                      onChanged: (value) {
                        setState1(() {
                          startDate = value.toString().split(" ")[0];
                        });
                      },
                      format: DateFormat("yyyy-MM-dd"),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime(
                            int.parse(firstDate.split("-")[0]),
                            int.parse(firstDate.split("-")[1]),
                            int.parse(firstDate.split("-")[2]),
                          ),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime.now(),
                        );
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: AppColor.buttonBG,
                        hintText: "Start Date",
                        hintStyle: TextStyle(
                          color: AppColor.lightText,
                        ),
                        enabledBorder: formBorder,
                        focusedBorder: formBorder,
                        errorBorder: formBorder,
                        focusedErrorBorder: formBorder,
                      ),
                    ),
                    startDate == "" || startDate == "null"
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              FontAwesomeIcons.calendarDays,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    DateTimeField(
                      onChanged: (value) {
                        setState1(() {
                          endDate = value.toString().split(" ")[0];
                        });
                      },
                      format: DateFormat("yyyy-MM-dd"),
                      onShowPicker: (context, currentValue) {
                        return showDatePicker(
                          context: context,
                          firstDate: DateTime(
                            int.parse(firstDate.split("-")[0]),
                            int.parse(firstDate.split("-")[1]),
                            int.parse(firstDate.split("-")[2]),
                          ),
                          initialDate: currentValue ?? DateTime.now(),
                          lastDate: DateTime.now(),
                        );
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        filled: true,
                        fillColor: AppColor.buttonBG,
                        hintText: "End Date",
                        hintStyle: TextStyle(
                          color: AppColor.lightText,
                        ),
                        enabledBorder: formBorder,
                        focusedBorder: formBorder,
                        errorBorder: formBorder,
                        focusedErrorBorder: formBorder,
                      ),
                    ),
                    endDate == "" || endDate == "null"
                        ? Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Icon(
                              FontAwesomeIcons.calendarDays,
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (startDate == "" ||
                        startDate == "null" ||
                        endDate == "" ||
                        endDate == "null") {
                      Message(
                        message: "Both start and end date is required.",
                        time: 3,
                        bgColor: Colors.red,
                        textColor: AppColor.onPrimary,
                      ).showMessage;
                    } else {
                      List<IncomeData> tempIncomeList = await IncomeHttp()
                          .getCategorizedSpecificIncome(
                              widget.category!, startDate, endDate);

                      int tempIncomeAmount = 0;
                      for (int i = 0; i < tempIncomeList.length; i++) {
                        tempIncomeAmount =
                            tempIncomeAmount + tempIncomeList[i].amount!;
                      }

                      setState(() {
                        incomeList = tempIncomeList;
                        incomeAmount = tempIncomeAmount;
                      });

                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: AppColor.onPrimary,
                    minimumSize: Size.zero,
                    padding: EdgeInsets.all(10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  Widget viewIncomes(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return incomeList.isEmpty
        ? SizedBox(
            height: 200,
            child: Center(
              child: Text(
                "No incomes",
                style: TextStyle(
                  color: AppColor.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(
              right: width * 0.03,
              bottom: 10,
              left: width * 0.03,
            ),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: incomeList.length,
              itemBuilder: ((context, index) {
                return ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  minLeadingWidth: 5,
                  minVerticalPadding: 5,
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (index + 1).toString() + ".",
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  title: Text(
                    incomeList[index].name!,
                    style: TextStyle(
                      color: AppColor.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    incomeList[index].createdAt!.split("T")[0],
                    style: TextStyle(
                      color: AppColor.lightText,
                    ),
                  ),
                  trailing: Text(
                    "Rs. " + incomeList[index].amount!.toString(),
                    style: TextStyle(
                      color: AppColor.text,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
