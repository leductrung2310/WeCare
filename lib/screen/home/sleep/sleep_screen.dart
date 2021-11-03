import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/screen/home/sleep/widget/drop_down_btn.dart';
import 'package:wecare_flutter/view_model/sleep_view_model.dart';

import '../../../constants.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context);

    List<String> listHour = [
      "1",
      "2",
      "3",
      "4",
      "5",
      "6",
      "7",
      "8",
      "9",
      "10",
      "11",
      "12",
    ];

    List<String> listMinute = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12',
      '13',
      '14',
      '15',
      '16',
      '17',
      '18',
      '19',
      '20',
      '21',
      '22',
      '23',
      '24',
      '25',
      '26',
      '27',
      '28',
      '29',
      '30',
      '31',
      '32',
      '33',
      '34',
      '35',
      '36',
      '37',
      '38',
      '39',
      '40',
      '41',
      '42',
      '43',
      '44',
      '45',
      '46',
      '47',
      '48',
      '49',
      '50',
      '51',
      '52',
      '53',
      '54',
      '55',
      '56',
      '57',
      '58',
      '59',
    ];

    List<String> list = ["AM", "PM"];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: sizeV * 2),
              SizedBox(
                height: sizeV * 5,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios_new),
                    ),
                    Text(
                      'Sleep',
                      style: TextStyle(
                        color: sleepColor,
                        fontSize: sizeH * 6,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: sizeH * 90,
                decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: sleepColor,
                    ),
                    borderRadius: BorderRadius.circular(24)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      width: sizeH * 80,
                      height: sleepViewModel.selected ? 0 : sizeV * 35,
                      alignment: sleepViewModel.selected
                          ? Alignment.center
                          : AlignmentDirectional.topCenter,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastLinearToSlowEaseIn,
                      child: Container(
                        color: primaryColor,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: sizeV * 5.5,
                                child: Text(
                                  Provider.of<SleepViewModel>(context,
                                          listen: false)
                                      .averageSleep
                                      .toString(),
                                  style: TextStyle(
                                    color: sleepColor,
                                    fontSize: sizeH * 10,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              Text(
                                "hs/day",
                                style: TextStyle(
                                  color: accentColor,
                                  fontSize: sizeH * 4,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Average \nsleep time",
                          style: TextStyle(
                            color: accentColor,
                            fontSize: sizeH * 5.5,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        SizedBox(
                          width: sizeH * 8,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.sentiment_dissatisfied,
                                    size: sizeH * 10,
                                    color: sleepViewModel.averageSleep < 7
                                        ? sleepColor
                                        : metalGreyColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Icon(
                                    Icons.sentiment_satisfied,
                                    size: sizeH * 10,
                                    color: sleepViewModel.averageSleep > 7
                                        ? sleepColor
                                        : metalGreyColor,
                                  ),
                                ),
                              ],
                            ),
                            CustomBTN(
                              height: sizeV * 4,
                              width: sizeH * 25,
                              color: sleepColor,
                              name: "Collapse",
                              textColor: whiteColor,
                              fontSize: sizeH * 3.5,
                              onPressed: () {
                                Provider.of<SleepViewModel>(context,
                                        listen: false)
                                    .selected = !Provider.of<SleepViewModel>(
                                        context,
                                        listen: false)
                                    .selected;
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                        child: Text(
                          "Select wake up time: ",
                          style: oBlackTitle,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropDownBtn(
                          listItem: listHour,
                          dropdownValue: sleepViewModel.dropdownHourValue,
                          onValueChanged: (newValue) {
                            sleepViewModel.dropdownHourValue = newValue;
                          },
                        ),
                        Text(
                          " : ",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: SizeConfig.blockSizeH! * 7,
                            color: sleepColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        DropDownBtn(
                          listItem: listMinute,
                          dropdownValue: sleepViewModel.dropdownMinuteValue,
                          onValueChanged: (newValue) {
                            sleepViewModel.dropdownMinuteValue = newValue;
                          },
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        DropDownBtn(
                          listItem: list,
                          dropdownValue: sleepViewModel.dropdownValue,
                          onValueChanged: (newValue) {
                            sleepViewModel.dropdownValue = newValue;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomBTN(
                      height: sizeV * 6.5,
                      width: sizeH * 60,
                      color: sleepColor,
                      name: "Calculate bed time",
                      textColor: whiteColor,
                      onPressed: () {},
                    ),
                    Container(
                      height: sizeV * 20,
                      width: sizeH * 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          width: 1,
                          color: sleepColor,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Best time to sleep:",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: SizeConfig.blockSizeH! * 4.5,
                                  color: accentColor,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              CustomBTN(
                                name: "11:15 PM (Suggested)",
                                onPressed: () {},
                                textColor: whiteColor,
                                color: sleepColor,
                                height: sizeV * 5,
                                width: sizeH * 62,
                                fontSize: sizeH * 5,
                              ),
                              SizedBox(
                                width: sizeH * 62,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomBTN(
                                      name: "2:15 PM",
                                      onPressed: () {},
                                      textColor: sleepColor,
                                      color: whiteColor,
                                      height: sizeV * 5,
                                      width: sizeH * 28,
                                      colorBorder: sleepColor,
                                    ),
                                    CustomBTN(
                                      name: "2:15 PM",
                                      onPressed: () {},
                                      textColor: sleepColor,
                                      color: whiteColor,
                                      height: sizeV * 5,
                                      width: sizeH * 28,
                                      colorBorder: sleepColor,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Alarm",
                                style: oBlackTitle,
                              ),
                              Switch(value: true, onChanged: (t) {})
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      height: 2,
                      color: metalGreyColor,
                      width: sizeH * 90,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: sizeV * 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                        child: Text(
                          "Or go to bed now... ",
                          style: oBlackTitle,
                        ),
                      ),
                    ),
                    CustomBTN(
                      height: sizeV * 6.5,
                      width: sizeH * 70,
                      color: sleepColor,
                      name: "Calculate wake-up time",
                      textColor: whiteColor,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
