import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/screen/home/sleep/module/scroll_clock.dart';

import '../../../../constants/constants.dart';
import '../../../../view_model/home_vm/sleep_view_model.dart';

class SelectWakeUpTime extends StatelessWidget {
  const SelectWakeUpTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context, listen: false);

    return Column(
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
        const ScrollClock(),
        const SizedBox(
          height: 16,
        ),
        CustomBTN(
          height: sizeV * 6.5,
          width: sizeH * 60,
          color: sleepColor,
          name: "Calculate bed time",
          textColor: whiteColor,
          onPressed: () {
            sleepViewModel.calculateSleepTime();
            sleepViewModel.showBestSleepTime = true;
            sleepViewModel.showBestWakeupTime = false;
          },
        ),
      ],
    );
  }
}
