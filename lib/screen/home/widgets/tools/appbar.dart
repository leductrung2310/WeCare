import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/sleep_view_model.dart';

import '../../../../constants/constants.dart';
import '../../../../view_model/home_vm/water_view_model.dart';

AppBar customAppBar(
    BuildContext context, Color color, String name, Widget child) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
        Provider.of<HistoryWorkoutViewModel>(context, listen: false)
            .resetHistoryChart(i: 0);
        Provider.of<HistoryWorkoutViewModel>(context, listen: false)
            .resetTime();
        Provider.of<HistoryWorkoutViewModel>(context, listen: false)
            .getTotalWeeklyHistoryToFirestore(context, "");
        Provider.of<WaterViewModel>(context, listen: false).resetChart();
        Provider.of<SleepViewModel>(context, listen: false).resetSleepInfo();
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color,
        size: SizeConfig.blockSizeV! * 3.5,
      ),
    ),
    toolbarHeight: SizeConfig.blockSizeV! * 7.5,
    title: Text(
      name,
      style: TextStyle(
        color: color,
        fontSize: SizeConfig.blockSizeH! * 7,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [child],
  );
}
