import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';

import '../../../../constants/constants.dart';
import '../../../../view_model/home_vm/sleep_view_model.dart';

class BestTimeToSleep extends StatelessWidget {
  const BestTimeToSleep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context);

    Widget firstBtn = CustomBTN(
      name:
          "${DateFormat.Hm().format(sleepViewModel.suggestedSleepTime1)} (Suggested)",
      onPressed: () {
        DateTime now = DateTime.now();
        DateTime firstSleepTime = sleepViewModel.suggestedSleepTime1;
        if (now.day == firstSleepTime.day) {
          if (now.hour == firstSleepTime.hour) {
            if (now.minute > firstSleepTime.minute) {
              sleepViewModel.isFirstSleepSuggestedClick = false;
            } else {
              sleepViewModel.isFirstSleepSuggestedClick =
                  !sleepViewModel.isFirstSleepSuggestedClick;
              sleepViewModel.isSecondSleepSuggestedClick = false;
              sleepViewModel.isThirdSleepSuggestedClick = false;
            }
          }
          if (now.hour > firstSleepTime.hour) {
            sleepViewModel.isFirstSleepSuggestedClick = false;
          }
          if (now.hour < firstSleepTime.hour) {
            sleepViewModel.isFirstSleepSuggestedClick =
                !sleepViewModel.isFirstSleepSuggestedClick;
            sleepViewModel.isSecondSleepSuggestedClick = false;
            sleepViewModel.isThirdSleepSuggestedClick = false;
          }
        }
        if (now.day > firstSleepTime.day) {
          sleepViewModel.isFirstSleepSuggestedClick = false;
        }
        if (now.day < firstSleepTime.day) {
          sleepViewModel.isFirstSleepSuggestedClick =
              !sleepViewModel.isFirstSleepSuggestedClick;
          sleepViewModel.isSecondSleepSuggestedClick = false;
          sleepViewModel.isThirdSleepSuggestedClick = false;
        }
      },
      height: sleepViewModel.showBestSleepTime ? sizeV * 6 : 0,
      width: sizeH * 65,
      fontSize: sizeH * 5,
      textColor:
          sleepViewModel.isFirstSleepSuggestedClick ? whiteColor : sleepColor,
      color:
          sleepViewModel.isFirstSleepSuggestedClick ? sleepColor : whiteColor,
    );

    Widget secondBtn = CustomBTN(
      name: DateFormat.Hm().format(sleepViewModel.suggestedSleepTime2),
      onPressed: () {
        DateTime now = DateTime.now();
        DateTime secondSleepTime = sleepViewModel.suggestedSleepTime2;
        if (now.day == secondSleepTime.day) {
          if (now.hour == secondSleepTime.hour) {
            if (now.minute > secondSleepTime.minute) {
              sleepViewModel.isSecondSleepSuggestedClick = false;
            } else {
              sleepViewModel.isSecondSleepSuggestedClick =
                  !sleepViewModel.isSecondSleepSuggestedClick;
              sleepViewModel.isFirstSleepSuggestedClick = false;
              sleepViewModel.isThirdSleepSuggestedClick = false;
            }
          }
          if (now.hour > secondSleepTime.hour) {
            sleepViewModel.isSecondSleepSuggestedClick = false;
          }
          if (now.hour < secondSleepTime.hour) {
            sleepViewModel.isSecondSleepSuggestedClick =
                !sleepViewModel.isSecondSleepSuggestedClick;
            sleepViewModel.isFirstSleepSuggestedClick = false;
            sleepViewModel.isThirdSleepSuggestedClick = false;
          }
        }
        if (now.day > secondSleepTime.day) {
          sleepViewModel.isSecondSleepSuggestedClick = false;
        }
        if (now.day < secondSleepTime.day) {
          sleepViewModel.isSecondSleepSuggestedClick =
              !sleepViewModel.isSecondSleepSuggestedClick;
          sleepViewModel.isFirstSleepSuggestedClick = false;
          sleepViewModel.isThirdSleepSuggestedClick = false;
        }
      },
      height: sleepViewModel.showBestSleepTime ? sizeV * 5 : 0,
      width: sizeH * 30,
      textColor:
          sleepViewModel.isSecondSleepSuggestedClick ? whiteColor : lightBlack,
      color:
          sleepViewModel.isSecondSleepSuggestedClick ? sleepColor : whiteColor,
    );

    Widget thirdBtn = CustomBTN(
      name: DateFormat.Hm().format(sleepViewModel.suggestedSleepTime3),
      onPressed: () {
        DateTime now = DateTime.now();
        DateTime thirdSleepTime = sleepViewModel.suggestedSleepTime3;
        if (now.day == thirdSleepTime.day) {
          if (now.hour == thirdSleepTime.hour) {
            if (now.minute > thirdSleepTime.minute) {
              sleepViewModel.isThirdSleepSuggestedClick = false;
            } else {
              sleepViewModel.isThirdSleepSuggestedClick =
                  !sleepViewModel.isThirdSleepSuggestedClick;
              sleepViewModel.isFirstSleepSuggestedClick = false;
              sleepViewModel.isSecondSleepSuggestedClick = false;
            }
          }
          if (now.hour > thirdSleepTime.hour) {
            sleepViewModel.isSecondSleepSuggestedClick = false;
          }
          if (now.hour < thirdSleepTime.hour) {
            sleepViewModel.isThirdSleepSuggestedClick =
                !sleepViewModel.isThirdSleepSuggestedClick;
            sleepViewModel.isFirstSleepSuggestedClick = false;
            sleepViewModel.isSecondSleepSuggestedClick = false;
          }
        }
        if (now.day > thirdSleepTime.day) {
          sleepViewModel.isThirdSleepSuggestedClick = false;
        }
        if (now.day < thirdSleepTime.day) {
          sleepViewModel.isThirdSleepSuggestedClick =
              !sleepViewModel.isThirdSleepSuggestedClick;
          sleepViewModel.isFirstSleepSuggestedClick = false;
          sleepViewModel.isSecondSleepSuggestedClick = false;
        }
      },
      height: sleepViewModel.showBestSleepTime ? sizeV * 5 : 0,
      width: sizeH * 30,
      textColor:
          sleepViewModel.isThirdSleepSuggestedClick ? whiteColor : lightBlack,
      color:
          sleepViewModel.isThirdSleepSuggestedClick ? sleepColor : whiteColor,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedContainer(
        height: sleepViewModel.showBestSleepTime ? sizeV * 20 : 0,
        width: sizeH * 90,
        alignment: sleepViewModel.showBestSleepTime
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
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        ],
                      ),
                      firstBtn,
                      SizedBox(
                        width: sizeH * 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            secondBtn,
                            thirdBtn,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          sleepViewModel.showBestSleepTime = false;
                        },
                        icon: const Icon(
                          Icons.arrow_circle_up,
                          color: sleepColor,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
