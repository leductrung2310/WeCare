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
                      CustomBTN(
                        name:
                            "${DateFormat.Hm().format(sleepViewModel.suggestedSleepTime1)} (Suggested)",
                        onPressed: () {
                          sleepViewModel.isFirstSleepSuggestedClick =
                              !sleepViewModel.isFirstSleepSuggestedClick;
                          sleepViewModel.isSecondSleepSuggestedClick = false;
                          sleepViewModel.isThirdSleepSuggestedClick = false;
                        },
                        height:
                            sleepViewModel.showBestSleepTime ? sizeV * 6 : 0,
                        width: sizeH * 65,
                        fontSize: sizeH * 5,
                        textColor: sleepViewModel.isFirstSleepSuggestedClick
                            ? whiteColor
                            : sleepColor,
                        color: sleepViewModel.isFirstSleepSuggestedClick
                            ? sleepColor
                            : whiteColor,
                      ),
                      SizedBox(
                        width: sizeH * 65,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBTN(
                              name: DateFormat.Hm()
                                  .format(sleepViewModel.suggestedSleepTime2),
                              onPressed: () {
                                sleepViewModel.isSecondSleepSuggestedClick =
                                    !sleepViewModel.isSecondSleepSuggestedClick;
                                sleepViewModel.isFirstSleepSuggestedClick =
                                    false;
                                sleepViewModel.isThirdSleepSuggestedClick =
                                    false;
                              },
                              height: sleepViewModel.showBestSleepTime
                                  ? sizeV * 5
                                  : 0,
                              width: sizeH * 30,
                              widthBorder: 1,
                              radius: 10,
                              textColor:
                                  sleepViewModel.isSecondSleepSuggestedClick
                                      ? whiteColor
                                      : lightBlack,
                              color: sleepViewModel.isSecondSleepSuggestedClick
                                  ? sleepColor
                                  : whiteColor,
                            ),
                            CustomBTN(
                              name: DateFormat.Hm()
                                  .format(sleepViewModel.suggestedSleepTime3),
                              onPressed: () {
                                sleepViewModel.isThirdSleepSuggestedClick =
                                    !sleepViewModel.isThirdSleepSuggestedClick;
                                sleepViewModel.isSecondSleepSuggestedClick =
                                    false;
                                sleepViewModel.isFirstSleepSuggestedClick =
                                    false;
                              },
                              height: sleepViewModel.showBestSleepTime
                                  ? sizeV * 5
                                  : 0,
                              width: sizeH * 30,
                              textColor:
                                  sleepViewModel.isThirdSleepSuggestedClick
                                      ? whiteColor
                                      : lightBlack,
                              color: sleepViewModel.isThirdSleepSuggestedClick
                                  ? sleepColor
                                  : whiteColor,
                            ),
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
