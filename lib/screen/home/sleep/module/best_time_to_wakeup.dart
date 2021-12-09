import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/view_model/home_vm/sleep_view_model.dart';

import '../../../../constants/constants.dart';

class BestTimeToWakeup extends StatelessWidget {
  const BestTimeToWakeup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedContainer(
        height: sleepViewModel.showBestWakeupTime ? sizeV * 20 : 0,
        width: sizeH * 88,
        alignment: sleepViewModel.showBestWakeupTime
            ? Alignment.center
            : AlignmentDirectional.topCenter,
        duration: const Duration(seconds: 2),
        curve: Curves.fastLinearToSlowEaseIn,
        child: SingleChildScrollView(
          child: Container(
            height: sizeV * 20,
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
                      "Best time to wakeup:",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: sizeH * 4.5,
                        color: accentColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    CustomBTN(
                      name:
                          "${sleepViewModel.suggestedWakeupTime1.hour}:${sleepViewModel.suggestedWakeupTime1.minute} ${sleepViewModel.suggestedWakeupTime1.period} (Suggested)",
                      onPressed: () {
                        sleepViewModel.firstWakeupButtonSelected =
                            !sleepViewModel.getFirstWakeupButtonSelected;
                      },
                      textColor:
                          sleepViewModel.getFirstWakeupButtonSelected == true
                              ? whiteColor
                              : sleepColor,
                      color: sleepViewModel.getFirstWakeupButtonSelected == true
                          ? sleepColor
                          : whiteColor,
                      height: sleepViewModel.showBestWakeupTime ? sizeV * 6 : 0,
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
                                '${sleepViewModel.suggestedWakeupTime2.hour}:${sleepViewModel.suggestedWakeupTime2.minute} ${sleepViewModel.suggestedWakeupTime2.period}',
                            onPressed: () {
                              sleepViewModel.secondWakeupButtonSelected =
                                  !sleepViewModel.getSecondWakeupButtonSelected;
                            },
                            textColor: sleepViewModel.getSecondWakeupButtonSelected == true
                                ? whiteColor
                                : sleepColor,
                            color: sleepViewModel.getSecondWakeupButtonSelected == true
                                ? sleepColor
                                : whiteColor,
                            height: sleepViewModel.showBestWakeupTime
                                ? sizeV * 5
                                : 0,
                            width: sizeH * 30,
                            fontSize: sizeH * 5,
                          ),
                          CustomBTN(
                            name:
                                "${sleepViewModel.suggestedWakeupTime3.hour}:${sleepViewModel.suggestedWakeupTime3.minute} ${sleepViewModel.suggestedWakeupTime3.period} ",
                            onPressed: () {
                              sleepViewModel.thirdWakeupButtonSelected =
                            !sleepViewModel.getThirdWakeupButtonSelected;
                            },
                            textColor: sleepViewModel.getThirdWakeupButtonSelected == true
                                ? whiteColor
                                : sleepColor,
                            color: sleepViewModel.getThirdWakeupButtonSelected == true
                                ? sleepColor
                                : whiteColor,
                            height: sleepViewModel.showBestWakeupTime
                                ? sizeV * 5
                                : 0,
                            width: sizeH * 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Provider.of<SleepViewModel>(context, listen: false)
                            .showBestWakeupTime = false;
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_up,
                        color: sleepColor,
                      ),
                    ),
                    Text(
                      "Alarm",
                      style: oBlackTitle,
                    ),
                    CupertinoSwitch(
                      value: sleepViewModel.alarmWakeupTime,
                      onChanged: (newValue) {
                        Provider.of<SleepViewModel>(context, listen: false)
                            .alarmWakeupTime = newValue;
                      },
                      activeColor: sleepColor,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
