import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/view_model/home_vm/sleep_view_model.dart';

import '../../../../constants/constants.dart';

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
        height: sleepViewModel.showBestSleepTime ? sizeV * 20 : 0,
        width: sizeH * 88,
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
              padding: const EdgeInsets.all(10),
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
                      CustomBTN(
                        name:
                            "${sleepViewModel.suggestedSleepTime1.hour}:${sleepViewModel.suggestedSleepTime1.minute} ${sleepViewModel.suggestedSleepTime1.period} (Suggested)",
                        onPressed: () {
                          Provider.of<SleepViewModel>(context, listen: false)
                              .selectedSleepButton = 0;
                        },
                        textColor: sleepViewModel.selectedSleepButton == 0
                            ? whiteColor
                            : sleepColor,
                        color: sleepViewModel.selectedSleepButton == 0
                            ? sleepColor
                            : whiteColor,
                        height:
                            sleepViewModel.showBestSleepTime ? sizeV * 6 : 0,
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
                                  "${sleepViewModel.suggestedSleepTime2.hour}:${sleepViewModel.suggestedSleepTime2.minute} ${sleepViewModel.suggestedSleepTime2.period}",
                              onPressed: () {
                                Provider.of<SleepViewModel>(context,
                                        listen: false)
                                    .selectedSleepButton = 1;
                              },
                              textColor: sleepViewModel.selectedSleepButton == 1
                                  ? whiteColor
                                  : sleepColor,
                              color: sleepViewModel.selectedSleepButton == 1
                                  ? sleepColor
                                  : whiteColor,
                              height: sleepViewModel.showBestSleepTime
                                  ? sizeV * 5
                                  : 0,
                              width: sizeH * 30,
                              widthBorder: 1,
                              radius: 10,
                            ),
                            CustomBTN(
                              name:
                                  "${sleepViewModel.suggestedSleepTime3.hour}:${sleepViewModel.suggestedSleepTime3.minute} ${sleepViewModel.suggestedSleepTime3.period} ",
                              onPressed: () {
                                Provider.of<SleepViewModel>(context,
                                        listen: false)
                                    .selectedSleepButton = 2;
                              },
                              textColor: sleepViewModel.selectedSleepButton == 2
                                  ? whiteColor
                                  : sleepColor,
                              color: sleepViewModel.selectedSleepButton == 2
                                  ? sleepColor
                                  : whiteColor,
                              height: sleepViewModel.showBestSleepTime
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
                              .showBestSleepTime = false;
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
                        value: sleepViewModel.alarmValue,
                        onChanged: (newValue) {
                          if (Provider.of<SleepViewModel>(context,
                                      listen: false)
                                  .selectedSleepButton ==
                              -1) {
                            Fluttertoast.showToast(
                                msg: 'Please choose time to sleep!');
                          } else {
                            Provider.of<SleepViewModel>(context, listen: false)
                                .alarmValue = newValue;
                          }
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
      ),
    );
  }
}
