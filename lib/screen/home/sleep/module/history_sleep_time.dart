import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/view_model/sleep_view_model.dart';

import '../../../../constants.dart';

class HistorySleepTime extends StatelessWidget {
  const HistorySleepTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context);
    return Container(
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
                        Provider.of<SleepViewModel>(context, listen: false)
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
                      Provider.of<SleepViewModel>(context, listen: false)
                              .selected =
                          !Provider.of<SleepViewModel>(context, listen: false)
                              .selected;
                    },
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
