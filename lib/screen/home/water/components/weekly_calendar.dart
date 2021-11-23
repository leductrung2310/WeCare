import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/view_model/weekly_calendar_viewmodel.dart';

class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;
    double sizeH = SizeConfig.blockSizeH!;

    WeeklyCalendarVM weeklyCalendarVM = Provider.of<WeeklyCalendarVM>(context);

    String _now = DateFormat('dd-MM-yyyy').format(DateTime.now());
    String curentTime =
        DateFormat('dd-MM-yyyy').format(weeklyCalendarVM.currentTime);

    Widget calenderBtn(IconData data, void Function() onPressed, Color color) {
      return InkWell(
        splashColor: lightBlack1.withOpacity(0.3),
        onTap: onPressed,
        borderRadius: BorderRadius.circular(40),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Icon(
              data,
              color: whiteColor,
              size: sizeV * 3.5,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: SizeConfig.blockSizeV! * 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          calenderBtn(
            Icons.keyboard_arrow_left,
            () => weeklyCalendarVM.changeCalendar(true),
            color,
          ),
          SizedBox(width: sizeH * 4),
          Text(
            weeklyCalendarVM.getCalendar(),
            style: TextStyle(
              fontSize: sizeV * 2.8,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              color: lightBlack,
            ),
          ),
          SizedBox(width: sizeH * 4),
          calenderBtn(
            Icons.keyboard_arrow_right,
            () => curentTime == _now
                ? {}
                : weeklyCalendarVM.changeCalendar(false),
            curentTime == _now ? lightBlack1 : color,
          ),
        ],
      ),
    );
  }
}