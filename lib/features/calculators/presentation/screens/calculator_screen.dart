import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trading_journal/core/widgets/custom_text_field.dart';
import 'package:trading_journal/core/widgets/popup_menu_button_widget.dart';
import 'package:toggle_switch/toggle_switch.dart' as ts;

import 'package:trading_journal/core/utils/constants/app_size.dart';
import 'package:trading_journal/core/widgets/cm_app_bar.dart';

enum Calculator {
  compoundInterest,
  dailyInterest,
  forexCompound,
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<CalculatorScreen> {
  final TextEditingController initInvController = TextEditingController();
  final TextEditingController rateController = TextEditingController();
  final TextEditingController yearsController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dayController = TextEditingController();

  @override
  void dispose() {
    initInvController.dispose();
    rateController.dispose();
    yearsController.dispose();
    monthController.dispose();
    dayController.dispose();
    super.dispose();
  }

  int _currencyValue = 0;
  String _calculatorTypeTitle = 'Compound Interest';
  String _timeTitle = 'Daily';
  String prefix = '\$';
  double _calculateResult = 0.0;

  String setPrefix(int index) {
    if (index == 0) {
      prefix = '\$';
    } else if (index == 1) {
      prefix = '€';
    } else {
      prefix = 'تومان';
    }
    return prefix;
  }

  // void _calculateMonthly() {
  //   double result = 0.0;
  //   int n = 12;
  //   double r = double.parse(rateController.text) / 100;
  //   double p = double.parse(initInvController.text);
  //   double t = double.parse(yearsController.text);

  //   result = p * pow(1 + r, n * t);

  //   setState(() {
  //     _calculateResult = result;
  //   });
  // }

  void _calculate() {
    double result = 0.0;
    // num r = 0.0;

    // Extracting input values
    double principal = double.tryParse(initInvController.text) ?? 0.0;
    double rate = double.tryParse(rateController.text) ?? 0.0;
    int years = int.tryParse(yearsController.text) ?? 0;
    int months = int.tryParse(monthController.text) ?? 0;
    int days = int.tryParse(dayController.text) ?? 0;

    // Convert time to years for the calculation
    double timeInYears = years + (months / 12) + (days / 365);
    // if (_timeTitle.contains('Daily')) {
    //   r = pow(1+ rate / 100, 365) -1;
    // } else if (_timeTitle.contains('Weekly')) {
    //   r = pow(1+ rate / 100,52)-1 ;
    // } else if (_timeTitle.contains('Monthly')) {
    //   r = pow(1+ rate / 100,12) -1;
    // } else {
    //   //yearly
    //   r = pow(1 + rate / 100, 1)-1;
    // }

    // A = P(1+i)^n
    // i = interest rate
    // Perform the calculation based on the selected calculator type
    switch (_calculatorTypeTitle) {
      case 'Compound Interest':
        if (_timeTitle.contains('Daily')) {
          result = principal * pow(1 + rate / 100, 365 * timeInYears);
        } else if (_timeTitle.contains('Monthly')) {
          result = principal * pow(1 + rate / 100, 12 * timeInYears);
        } else if (_timeTitle.contains('Weekly')) {
          result = principal * pow(1 + rate / 100, 52 * timeInYears);
        } else {
          result = principal * pow(1 + rate / 100, 1 * timeInYears);
        }

        break;
      case 'Daily Compound':
        result = principal * pow(1 + rate / 100, 365 * timeInYears);
        break;
      case 'Forex Compound':
        // Perform forex compound calculation logic here
        break;
      default:
        // Handle other cases or set a default result
        break;
    }
    setState(() {
      _calculateResult = result;
    });
  }

  void _setCalculatorTypeTitle(String title) {
    _calculatorTypeTitle = title;
  }

  void _setTimeTitle(String title) {
    _timeTitle = title;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff000000),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CmAppBar(
                title: 'Calculators',
              ),
              gapH32,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        child: PopUpMenuButtonWidget(
                          menuList: [
                            ...MenuItem.calculators
                                .map((item) => PopupMenuItem<PopupMenuItemModel>(
                                      padding: const EdgeInsets.only(
                                          left: 24, right: 24),
                                      child: Text(
                                        item.title!,
                                        style: const TextStyle(
                                            color: Color(0xffbdbdbd)),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _setCalculatorTypeTitle(item.title!);
                                        });
                                      },
                                    ))
                                .toList()
                          ],
                          title: _calculatorTypeTitle,
                        ),
                      ),
                      gapH16,
                      SizedBox(
                        width: size.width * .6,
                        height: 40,
                        child: CustomTextFieldWidget(
                          textInputType: TextInputType.number,
                          controller: initInvController,
                          hintText: 'Initial Investment',
                          prefix: prefix,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * .3,
                    child: Align(
                      alignment: Alignment.center,
                      child: ts.ToggleSwitch(
                        //minWidth: MediaQuery.of(context).size.width / 2,
                        //minHeight: 60.0,
                        // customHeights: const [30, 30,30],
                        minHeight: 30,
                        isVertical: true,
                        fontSize: 14.0,
                        initialLabelIndex: _currencyValue,
                        activeBgColor: const [Color(0xff212121)],
                        activeFgColor: const Color(0xffffca28),
                        inactiveBgColor: const Color(0xff212121),
                        inactiveFgColor: const Color(0xff616161),
                        totalSwitches: 3,
                        labels: const [
                          '\$',
                          '€',
                          'تومان',
                        ],
                        onToggle: (index) {
                          //print('switched to: $index');
                          _currencyValue = index!;
                          setState(() {
                            setPrefix(index);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              gapH16,
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .25,
                    height: 40,
                    child: CustomTextFieldWidget(
                      textInputType: TextInputType.number,
                      controller: yearsController,
                      hintText: 'Years',
                    ),
                  ),
                  SizedBox(
                    width: size.width * .03,
                  ),
                  SizedBox(
                    width: size.width * .25,
                    height: 40,
                    child: CustomTextFieldWidget(
                      textInputType: TextInputType.number,
                      controller: monthController,
                      hintText: 'Month',
                    ),
                  ),
                  SizedBox(
                    width: size.width * .03,
                  ),
                  if (_calculatorTypeTitle.contains('Daily Compound'))
                    SizedBox(
                      width: size.width * .25,
                      height: 40,
                      child: CustomTextFieldWidget(
                        textInputType: TextInputType.number,
                        controller: dayController,
                        hintText: 'days',
                      ),
                    ),
                ],
              ),
              gapH16,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width * .6,
                    height: 40,
                    child: CustomTextFieldWidget(
                      textInputType: TextInputType.number,
                      controller: rateController,
                      hintText: 'Interest Rate',
                      prefix: '%',
                    ),
                  ),
                  SizedBox(
                    width: size.width * .3,
                    child: PopUpMenuButtonWidget(
                      menuList: [
                        ...MenuItem.time
                            .map((item) => PopupMenuItem<PopupMenuItemModel>(
                                  padding:
                                      const EdgeInsets.only(left: 24, right: 24),
                                  child: Text(
                                    item.title!,
                                    style:
                                        const TextStyle(color: Color(0xffbdbdbd)),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _setTimeTitle(item.title!);
                                    });
                                  },
                                ))
                            .toList()
                      ],
                      title: _timeTitle,
                      widthSize: size.width * .3,
                    ),
                  ),
                ],
              ),
              gapH24,
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      _calculate();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff212121),
                        foregroundColor: const Color(0xffffca28)),
                    child: const Text(
                      'Calculate',
                    )),
              ),
              gapH32,
              Container(
                width: size.width / 2,
                height: size.height * .1,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xff212121),
                ),
                child: Text(
                  'Result is : $_calculateResult',
                  style: const TextStyle(color: Color(0xffffca28), fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
