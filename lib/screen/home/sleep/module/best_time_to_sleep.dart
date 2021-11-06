import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/view_model/sleep_view_model.dart';

import '../../../../constants.dart';

class BestTimeToSleep extends StatelessWidget {
  const BestTimeToSleep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedContainer(
        height: sleepViewModel.calculateFrame ? 0 : sizeV * 20,
        width: sizeH * 88,
        alignment: sleepViewModel.calculateFrame
            ? Alignment.center
            : AlignmentDirectional.topCenter,
        duration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: sleepColor,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    name:
                        "${sleepViewModel.suggestedTime1.hour}:${sleepViewModel.suggestedTime1.minute} ${sleepViewModel.suggestedTime1.period} (Suggested)",
                    onPressed: () {
                      Provider.of<SleepViewModel>(context, listen: false)
                          .selectedButton = 0;
                    },
                    textColor: sleepViewModel.selectedButton == 0
                        ? whiteColor
                        : sleepColor,
                    color: sleepViewModel.selectedButton == 0
                        ? sleepColor
                        : whiteColor,
                    height: sleepViewModel.calculateFrame ? 0 : sizeV * 6,
                    width: sizeH * 65,
                    fontSize: sizeH * 5,
                  ),
                  SizedBox(
                    width: sizeH * 65,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBTN(
                          name:
                              "${sleepViewModel.suggestedTime2.hour}:${sleepViewModel.suggestedTime2.minute} ${sleepViewModel.suggestedTime2.period}",
                          onPressed: () {
                            Provider.of<SleepViewModel>(context, listen: false)
                                .selectedButton = 1;
                          },
                          textColor: sleepViewModel.selectedButton == 1
                              ? whiteColor
                              : sleepColor,
                          color: sleepViewModel.selectedButton == 1
                              ? sleepColor
                              : whiteColor,
                          height: sleepViewModel.calculateFrame ? 0 : sizeV * 5,
                          width: sizeH * 30,
                          widthBorder: 1,
                          radius: 10,
                        ),
                        CustomBTN(
                          name:
                              "${sleepViewModel.suggestedTime3.hour}:${sleepViewModel.suggestedTime3.minute} ${sleepViewModel.suggestedTime3.period} ",
                          onPressed: () {
                            Provider.of<SleepViewModel>(context, listen: false)
                                .selectedButton = 2;
                          },
                          textColor: sleepViewModel.selectedButton == 2
                              ? whiteColor
                              : sleepColor,
                          color: sleepViewModel.selectedButton == 2
                              ? sleepColor
                              : whiteColor,
                          height: sleepViewModel.calculateFrame ? 0 : sizeV * 5,
                          width: sizeH * 30,
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
                  CupertinoSwitch(
                    value: sleepViewModel.alarmValue,
                    onChanged: (newValue) {
                      Provider.of<SleepViewModel>(context, listen: false)
                          .alarmValue = newValue;
                    },
                    activeColor: sleepColor,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
