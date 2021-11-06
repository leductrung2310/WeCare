import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/screen/home/sleep/widget/drop_down_btn.dart';
import 'package:wecare_flutter/view_model/sleep_view_model.dart';

import '../../../constants.dart';
import 'module/best_time_to_sleep.dart';
import 'module/history_sleep_time.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              const HistorySleepTime(),
              const SelectWakeUpTime(),
              const BestTimeToSleep(),
              Container(
                height: 2,
                color: metalGreyColor,
                width: sizeH * 90,
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
                height: sizeV * 30.5,
                width: sizeH * 70,
                color: sleepColor,
                name: "Calculate wake-up time",
                textColor: whiteColor,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
