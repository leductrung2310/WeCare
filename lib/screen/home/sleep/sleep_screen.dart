import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/screen/home/sleep/module/best_time_to_wakeup.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';

import '../../../constants/constants.dart';
import '../../../view_model/home_vm/sleep_view_model.dart';
import 'module/best_time_to_sleep.dart';
import 'module/select_wake_up_time.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final sleepViewModel = Provider.of<SleepViewModel>(context);

    return Scaffold(
      appBar: customAppBar(
        context,
        sleepColor,
        'Sleep',
        const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: sizeV),
              Image.asset(
                'assets/images/home/sleep/dream.png',
                height: sizeV * 35,
                width: sizeH * 80,
              ),
              const SelectWakeUpTime(),
              const BestTimeToSleep(),
              Divider(
                height: 0,
                thickness: 2.5,
                color: metalGreyColor,
                indent: sizeH * 5,
                endIndent: sizeH * 5,
              ),
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
                onPressed: () {
                  sleepViewModel.calculateWakeupTime();
                  sleepViewModel.showBestWakeupTime = true;
                  sleepViewModel.showBestSleepTime = false;
                },
              ),
              const BestTimeToWakeup(),
              SizedBox(height: sizeV * 3),
            ],
          ),
        ),
      ),
    );
  }
}
