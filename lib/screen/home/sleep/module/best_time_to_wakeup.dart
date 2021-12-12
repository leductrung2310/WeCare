import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';

import '../../../../constants/constants.dart';
import '../../../../view_model/home_vm/sleep_view_model.dart';

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
        width: sizeH * 90,
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
                          "${DateFormat.Hm().format(sleepViewModel.suggestedWakeupTime1)} (Suggested)",
                      onPressed: () {},
                      height: sleepViewModel.showBestWakeupTime ? sizeV * 6 : 0,
                      textColor: sleepColor,
                      width: sizeH * 65,
                      fontSize: sizeH * 5,
                    ),
                    SizedBox(
                      width: sizeH * 65,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomBTN(
                            name: DateFormat.Hm()
                                .format(sleepViewModel.suggestedWakeupTime2),
                            onPressed: () {},
                            height: sleepViewModel.showBestWakeupTime
                                ? sizeV * 5
                                : 0,
                            width: sizeH * 30,
                            fontSize: sizeH * 5,
                          ),
                          CustomBTN(
                            name: DateFormat.Hm()
                                .format(sleepViewModel.suggestedWakeupTime3),
                            onPressed: () {},
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        sleepViewModel.showBestWakeupTime = false;
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
    );
  }
}
