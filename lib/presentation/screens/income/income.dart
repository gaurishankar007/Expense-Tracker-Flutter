import 'package:cached_network_image/cached_network_image.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:expense_tracker/presentation/blocs/income/income_bloc.dart';
import 'package:expense_tracker/presentation/widgets/error_fetching_data.dart';
import 'package:expense_tracker/presentation/widgets/no_internet.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/config/category.dart';
import 'package:flutter/material.dart';

import '../../../data/model/income_model.dart';
import '../../../data/remote/income_http.dart';
import '../../../config/themes/constant.dart';
import '../../widgets/message.dart';
import '../../widgets/navigator.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({Key? key}) : super(key: key);

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OutlineInputBorder formBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: AppColor.buttonBG,
      width: 2,
      style: BorderStyle.solid,
    ),
  );

  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: Colors.black87,
  );

  int touchedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late TimePeriod timePeriod;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: BlocBuilder<IncomeBloc, IncomeState>(
          builder: (context, state) {
            if (state is IncomeLoadingState) {
              if (state.internet == false) {
                return NoInternet();
              }

              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  color: Theme.of(context).primaryColor,
                  backgroundColor: AppColor.buttonBG,
                ),
              );
            } else if (state is ErrorState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ErrorFetchingData(),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<IncomeBloc>(context)
                          .add(IncomeLoadedEvent());
                    },
                    child: Text(
                      "Try Again",
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 25,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is IncomeLoadedState) {
              timePeriod = state.timePeriod;
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                  top: 10,
                  right: AppSize.width(context) * 0.03,
                  left: AppSize.width(context) * 0.03,
                  bottom: 50,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                                imageUrl: state.profilePicture,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: AppColor.primary,
                                    strokeWidth: 2,
                                    backgroundColor:
                                        AppColor.primary.withOpacity(.5),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  size: AppSize.icon,
                                  color: AppColor.primary,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Your Incomes",
                              style: TextStyle(
                                color: AppColor.text,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<IncomeBloc>(context).add(
                                IncomeLoadedNewEvent(
                                    timePeriod: TimePeriod.searching));
                            showDialog(
                              context: context,
                              builder: (ctx) {
                                return selectDate(
                                  context,
                                  state.firstIncomeDate,
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.search,
                            color: AppColor.text,
                            size: 30,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: AppSize.width(context) * .30,
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.timePeriod == TimePeriod.today) {
                                return;
                              }
                              BlocProvider.of<IncomeBloc>(context).add(
                                  IncomeLoadedNewEvent(
                                      timePeriod: TimePeriod.today));
                            },
                            child: Text(
                              "Today",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  state.timePeriod == TimePeriod.today
                                      ? Theme.of(context).primaryColor
                                      : AppColor.buttonBG,
                              foregroundColor:
                                  state.timePeriod == TimePeriod.today
                                      ? AppColor.onPrimary
                                      : AppColor.text,
                              minimumSize: Size.zero,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppSize.width(context) * .30,
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.timePeriod == TimePeriod.thisWeek) {
                                return;
                              }
                              BlocProvider.of<IncomeBloc>(context).add(
                                  IncomeLoadedNewEvent(
                                      timePeriod: TimePeriod.thisWeek));
                            },
                            child: Text(
                              "This Week",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  state.timePeriod == TimePeriod.thisWeek
                                      ? Theme.of(context).primaryColor
                                      : AppColor.buttonBG,
                              foregroundColor:
                                  state.timePeriod == TimePeriod.thisWeek
                                      ? AppColor.onPrimary
                                      : AppColor.text,
                              minimumSize: Size.zero,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppSize.width(context) * .30,
                          child: ElevatedButton(
                            onPressed: () {
                              if (state.timePeriod == TimePeriod.thisMonth) {
                                return;
                              }
                              BlocProvider.of<IncomeBloc>(context).add(
                                  IncomeLoadedNewEvent(
                                      timePeriod: TimePeriod.thisMonth));
                            },
                            child: Text(
                              "This Month",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  state.timePeriod == TimePeriod.thisMonth
                                      ? Theme.of(context).primaryColor
                                      : AppColor.buttonBG,
                              foregroundColor:
                                  state.timePeriod == TimePeriod.thisMonth
                                      ? AppColor.onPrimary
                                      : AppColor.text,
                              minimumSize: Size.zero,
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    viewIncome(
                      context,
                      state.timePeriod,
                      state,
                      state.incomes,
                      state.incomeAmount,
                      state.incomeCategories,
                    ),
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return addIncome(context, timePeriod);
              },
            );
          },
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.add,
            color: AppColor.onPrimary,
          ),
        ),
      ),
      bottomNavigationBar: PageNavigator(pageIndex: 1),
    );
  }

  Widget addIncome(
    BuildContext context,
    TimePeriod timePeriod,
  ) {
    final formKey = GlobalKey<FormState>();
    String name = "", amount = "", category = "Other";

    return StatefulBuilder(builder: (context1, setState1) {
      return AlertDialog(
        backgroundColor: AppColor.backgroundLight,
        title: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                onSaved: ((value) {
                  name = value!;
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.buttonBG,
                  hintText: "Enter name",
                  hintStyle: TextStyle(
                    color: AppColor.lightText,
                  ),
                  enabledBorder: formBorder,
                  focusedBorder: formBorder,
                  errorBorder: formBorder,
                  focusedErrorBorder: formBorder,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                onSaved: ((value) {
                  amount = value!;
                }),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.buttonBG,
                  hintText: "Enter amount",
                  hintStyle: TextStyle(
                    color: AppColor.lightText,
                  ),
                  enabledBorder: formBorder,
                  focusedBorder: formBorder,
                  errorBorder: formBorder,
                  focusedErrorBorder: formBorder,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColor.buttonBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton(
                  value: category,
                  elevation: 20,
                  underline: SizedBox(),
                  style: TextStyle(
                    color: AppColor.text,
                    fontSize: 15,
                  ),
                  isExpanded: true,
                  dropdownColor: AppColor.buttonBG,
                  borderRadius: BorderRadius.circular(5),
                  onChanged: (String? newValue) {
                    setState1(() {
                      category = newValue!;
                    });
                  },
                  items: Category.incomeCategory.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size.zero,
              padding: EdgeInsets.all(10),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                Navigator.pop(context);

                BlocProvider.of<IncomeBloc>(context).add(IncomeAddedEvent(
                  timePeriod: timePeriod,
                  scaffoldKey: _scaffoldKey,
                  name: name,
                  amount: amount,
                  category: category,
                ));
              } else {
                Message(
                  message: "Provide all information",
                  time: 3,
                  bgColor: Colors.green,
                  textColor: AppColor.onPrimary,
                ).showMessage;
              }
            },
            child: Text("Add"),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              minimumSize: Size.zero,
              padding: EdgeInsets.all(10),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
                style: BorderStyle.solid,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              category = "Other";
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      );
    });
  }

  Widget selectDate(BuildContext context, String firstDate) {
    String startDate = "", endDate = "";

    return StatefulBuilder(builder: (context1, setState1) {
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
                        message: "Both start and end date is required",
                        time: 3,
                        bgColor: Colors.green,
                        textColor: AppColor.onPrimary,
                      ).showMessage;
                    } else {
                      Navigator.pop(context);
                      BlocProvider.of<IncomeBloc>(context).add(
                          IncomeSearchEvent(
                              timePeriod: TimePeriod.searching,
                              startDate: startDate,
                              endDate: endDate));
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

  Widget viewIncome(
    BuildContext context,
    TimePeriod timePeriod,
    IncomeState state,
    List<IncomeData> incomes,
    int amount,
    List<IncomeCategorized> category,
  ) {
    if (incomes.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Row(
              children: [
                Text(
                  "Income Categories",
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppSize.width(context) * .5,
            height: AppSize.width(context) * .5,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }

                    touchedIndex =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                }),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: category
                    .asMap()
                    .map((index, data) {
                      final isTouched = index == touchedIndex;
                      final double fontSize = isTouched ? 20 : 15;
                      final double radius = isTouched
                          ? AppSize.width(context) * .18
                          : AppSize.width(context) * .16;

                      final pieData = PieChartSectionData(
                        value: double.parse(
                            ((data.amount! / amount) * 100).toStringAsFixed(1)),
                        title:
                            "${((data.amount! / amount) * 100).toStringAsFixed(1)}%",
                        color: IncomeCategoryColors.colorList[
                            Category.incomeCategory.indexOf(data.category!)],
                        radius: radius,
                        titleStyle: TextStyle(
                          color: AppColor.onPrimary,
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      );

                      return MapEntry(index, pieData);
                    })
                    .values
                    .toList(),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: category.length,
            itemBuilder: ((context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: IncomeCategoryColors.colorList[Category
                          .incomeCategory
                          .indexOf(category[index].category!)],
                      radius: 6,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    RichText(
                      text: TextSpan(
                        text: category[index].category!,
                        style: TextStyle(
                          color: AppColor.text,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: "= ",
                  style: TextStyle(
                    color: AppColor.text,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  children: [
                    TextSpan(
                      text: "Rs.${amount.toString()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Text(
                "Income Items",
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: incomes.length,
            itemBuilder: ((context, index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                minLeadingWidth: 5,
                minVerticalPadding: 5,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                onTap: () {
                  if (state is IncomeLoadedState &&
                      state.timePeriod == TimePeriod.thisMonth) {
                    return;
                  }

                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (builder) {
                      return operationIncome(
                        context,
                        IncomeData(
                          id: incomes[index].id,
                          name: incomes[index].name,
                          amount: incomes[index].amount,
                          category: incomes[index].category,
                        ),
                        timePeriod,
                      );
                    },
                  );
                },
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
                  incomes[index].name!,
                  style: TextStyle(
                    color: AppColor.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  incomes[index].category!,
                  style: TextStyle(
                    color: AppColor.lightText,
                  ),
                ),
                trailing: Text(
                  "Rs. " + incomes[index].amount!.toString(),
                  style: TextStyle(
                    color: AppColor.text,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
          ),
        ],
      );
    } else if (state is IncomeLoadedState &&
        state.timePeriod != TimePeriod.searching) {
      return SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No incomes",
              style: TextStyle(
                color: AppColor.text,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size.zero,
                padding: EdgeInsets.all(10),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return addIncome(context, timePeriod);
                  },
                );
              },
              child: Text("Add Income"),
            ),
          ],
        ),
      );
    } else if (state is IncomeLoadedState &&
        state.timePeriod == TimePeriod.searching) {
      return SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No incomes",
              style: TextStyle(
                color: AppColor.text,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    } else {
      return SizedBox();
    }
  }

  Widget operationIncome(
      BuildContext context, IncomeData incomeData, TimePeriod timePeriod) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: AppSize.width(context) * .20,
      ),
      decoration: BoxDecoration(
        color: AppColor.backgroundLight,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15.0),
          topRight: const Radius.circular(15.0),
        ),
      ),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              minimumSize: Size.zero,
              padding: EdgeInsets.all(0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (builder) {
                  return editIncome(
                    context,
                    incomeData,
                    timePeriod,
                  );
                },
              );
            },
            child: SizedBox(
              height: 45,
              width: 75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.edit),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Edit",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: Size.zero,
              padding: EdgeInsets.all(0),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () async {
              Navigator.pop(context);
              BlocProvider.of<IncomeBloc>(context).add(IncomeRemovedEvent(
                  timePeriod: timePeriod, id: incomeData.id!));
            },
            child: SizedBox(
              height: 45,
              width: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.delete),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Remove",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget editIncome(
      BuildContext context, IncomeData incomeData, TimePeriod timePeriod) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameTEC = TextEditingController(),
        amountTEC = TextEditingController();
    nameTEC.text = incomeData.name!;
    amountTEC.text = incomeData.amount!.toString();
    String categoryTEC = incomeData.category!;

    return StatefulBuilder(builder: (context1, setState1) {
      return AlertDialog(
        backgroundColor: AppColor.backgroundLight,
        title: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameTEC,
                onSaved: ((value) {
                  nameTEC.text = value!;
                }),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.buttonBG,
                  hintText: "Enter name",
                  hintStyle: TextStyle(
                    color: AppColor.text,
                  ),
                  enabledBorder: formBorder,
                  focusedBorder: formBorder,
                  errorBorder: formBorder,
                  focusedErrorBorder: formBorder,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: amountTEC,
                onSaved: ((value) {
                  amountTEC.text = value!;
                }),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColor.buttonBG,
                  hintText: "Enter amount",
                  hintStyle: TextStyle(
                    color: AppColor.text,
                  ),
                  enabledBorder: formBorder,
                  focusedBorder: formBorder,
                  errorBorder: formBorder,
                  focusedErrorBorder: formBorder,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColor.buttonBG,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton(
                  value: categoryTEC,
                  elevation: 20,
                  underline: SizedBox(),
                  style: TextStyle(
                    color: AppColor.text,
                    fontSize: 15,
                  ),
                  isExpanded: true,
                  dropdownColor: AppColor.buttonBG,
                  borderRadius: BorderRadius.circular(5),
                  onChanged: (String? newValue) {
                    setState1(() {
                      categoryTEC = newValue!;
                    });
                  },
                  items: Category.incomeCategory.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
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
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                Navigator.pop(context);

                BlocProvider.of<IncomeBloc>(context).add(IncomeEditedEvent(
                  timePeriod: timePeriod,
                  incomeData: IncomeData(
                    id: incomeData.id,
                    name: nameTEC.text,
                    amount: int.parse(amountTEC.text),
                    category: categoryTEC,
                  ),
                ));
              } else {
                Message(
                  message: "Provide all information",
                  time: 3,
                  bgColor: Colors.green,
                  textColor: AppColor.onPrimary,
                ).showMessage;
              }
            },
            child: Text("Edit"),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              minimumSize: Size.zero,
              padding: EdgeInsets.all(10),
              side: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
                style: BorderStyle.solid,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Cancel"),
          ),
        ],
      );
    });
  }
}
