import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/view_model/home_vm/weekly_calendar_viewmodel.dart';

class WeekGoal extends StatelessWidget {
  const WeekGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final weeklyCalendar = Provider.of<WeeklyCalendarVM>(context);

    int firstDayOfWeek = weeklyCalendar.startOfWeek.day;

    return InkWell(
      onTap: () => {
        Navigator.of(context).pushNamed(Routes.fitnessHistoryScreen),
      },
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: metalGreyColor,
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // change position of shadow
            )
          ],
        ),
        height: sizeV * 15,
        width: sizeH * 95,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Text(
                    'WEEK GOAL',
                    style: oBlackTitle,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomeDate(text: "$firstDayOfWeek"),
                CustomeDate(text: '${firstDayOfWeek + 1}'),
                CustomeDate(text: '${firstDayOfWeek + 2}'),
                CustomeDate(text: '${firstDayOfWeek + 3}'),
                CustomeDate(text: '${firstDayOfWeek + 4}'),
                CustomeDate(text: '${firstDayOfWeek + 5}'),
                CustomeDate(text: '${firstDayOfWeek + 6}'),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomeDate extends StatelessWidget {
  final String text;
  const CustomeDate({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: grey1,
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: oSubtitle,
        ),
      ),
    );
  }
}
