import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:provider/provider.dart';

import '../../../../constants/constants.dart';
import '../../../../services/authentic_service.dart';
import '../../../../view_model/home_vm/sleep_view_model.dart';

class ScrollClock extends StatelessWidget {
  const ScrollClock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    AuthenticService authenticService = Provider.of<AuthenticService>(context);
    SleepViewModel sleepViewModel = Provider.of<SleepViewModel>(context);

    DateTime userWakeupTime = authenticService.loggedInUser.wakeupTime ?? DateTime.now();
    var wakeupTime = DateTime.parse(userWakeupTime.toString());

    DateTime dateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      wakeupTime.hour,
      wakeupTime.minute,
    );

    return Container(
      height: sizeV * 23,
      width: sizeH * 60,
      decoration: BoxDecoration(
        color: whiteColor,
        border: Border.all(
          color: sleepColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TimePickerSpinner(
        //is24HourMode: false,
        normalTextStyle: TextStyle(
          fontFamily: 'poppins',
          fontSize: sizeH * 5,
          color: lightBlack1,
          fontWeight: FontWeight.w500,
        ),
        highlightedTextStyle: TextStyle(
          fontSize: sizeH * 8,
          color: sleepColor,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w600,
        ),
        isForce2Digits: true,
        spacing: sizeH * 12,
        time: dateTime,
        onTimeChange: (time) {
          sleepViewModel.wakeupTime = time;
          authenticService.loggedInUser.wakeupTime = time;
        },
      ),
    );
  }
}
