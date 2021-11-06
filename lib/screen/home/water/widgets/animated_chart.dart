import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/home/water/components/fl_bar_chart.dart';
import 'package:wecare_flutter/view_model/weekly_calendar_viewmodel.dart';

import '../../../../constants.dart';

class AnimatedChart extends StatelessWidget {
  const AnimatedChart({
    Key? key,
    required this.color,
    required this.barWidth,
    required this.width,
    required this.height,
    required this.maxY,
    required this.flTitlesData,
  }) : super(key: key);

  final Color color;
  final double barWidth;
  final double width;
  final double height;
  final double maxY;
  final FlTitlesData flTitlesData;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        //color: lightWaterColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color,
          width: 2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeH * 3,
          vertical: sizeV * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeeklyCalendar(sizeV: sizeV, color: color),
            SizedBox(
              height: sizeV * 2,
            ),
            Expanded(
              child: FlBarChart(
                maxY: maxY,
                sizeH: sizeH,
                flTitlesData: flTitlesData,
                barWidth: barWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeeklyCalendar extends StatelessWidget {
  const WeeklyCalendar({
    Key? key,
    required this.sizeV,
    required this.color,
  }) : super(key: key);

  final double sizeV;
  final Color color;

  @override
  Widget build(BuildContext context) {
    DateTime? _selectedDate;

    return SizedBox(
      height: sizeV * 6,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              _selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2010),
                lastDate: DateTime(2030),
              );
              var changeDate = context.read<CalendarViewModel>();
              changeDate.changeCalendar(_selectedDate!);
            },
            icon: Icon(
              Icons.event_note,
              color: color,
              size: sizeV * 5,
            ),  
          ),
          SizedBox(width: sizeV * 2),
          Consumer<CalendarViewModel>(
            builder: (context, calendarViewModel, child) => Text(
              calendarViewModel.time,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: sizeV*3.4,
                color: lightBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
