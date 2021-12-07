import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/statistic_data/water_statistic_data.dart';
import 'package:wecare_flutter/screen/home/water/widgets/animated_chart.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';

import '../../../../constants/constants.dart';
import '../../../../view_model/home_vm/weekly_calendar_viewmodel.dart';

class WaterWeeklyChart extends StatelessWidget {
  const WaterWeeklyChart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    WaterViewModel waterViewModel = Provider.of<WaterViewModel>(context);

    AuthenticService authenticService = Provider.of<AuthenticService>(context);

    List<WaterData> waterHisListBarData = waterViewModel.getWaterHistoryList;

    double interval = authenticService.getDesiredAmount / 4;
    String stringInterval = interval.toStringAsFixed(1);

    //? convert each item to a string by using JSON encoding
    //final jsonList = waterHisListBarData.map((e) => jsonEncode(e)).toList();
    //? using toSet - toList strategy
    //final uniqueJsonList = jsonList.toSet().toList();
    //? convert each item back to the original form using JSON decoding
    //final result = uniqueJsonList.map((e) => jsonDecode(e)).toList();

    List<WaterStatisticData> waterBarData = [
      WaterStatisticData(id: 1, name: 'Mo'),
      WaterStatisticData(id: 2, name: 'Tu'),
      WaterStatisticData(id: 3, name: 'We'),
      WaterStatisticData(id: 4, name: 'Th'),
      WaterStatisticData(id: 5, name: 'Fr'),
      WaterStatisticData(id: 6, name: 'Sa'),
      WaterStatisticData(id: 7, name: 'Su'),
    ];

    SideTitles getBottomTitles() {
      return SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          color: lightBlack1,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.blockSizeV! * 1.8,
        ),
        interval: 1,
        getTitles: (double id) =>
            waterBarData.firstWhere((element) => element.id == id.toInt()).name,
      );
    }

    SideTitles getSideTitles() {
      return SideTitles(
        showTitles: true,
        getTextStyles: (context, value) => TextStyle(
          color: lightBlack1,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w700,
          fontSize: SizeConfig.blockSizeV! * 1.6,
        ),
        margin: 10,
        interval: double.parse(stringInterval),
        reservedSize: 30,
        getTitles: (double value) => value == 0 ? '0' : '${value}L',
      );
    }

    List<BarChartGroupData> waterBarChartList = waterHisListBarData
        .map((WaterData data) => BarChartGroupData(
              x: data.id,
              barRods: [
                BarChartRodData(
                  y: data.waterIndex,
                  width: sizeH * 2.5,
                  colors: [waterColor],
                ),
              ],
            ))
        .toList();

    return Align(
      alignment: Alignment.topCenter,
      child: ChangeNotifierProvider(
        create: (context) => WeeklyCalendarVM(),
        child: AnimatedChart(
          color: waterColor,
          barWidth: sizeH * 4,
          width: sizeH * 90,
          height: sizeV * 45,
          barChartGroupData: waterBarChartList,
          onPressed: () {
            waterViewModel.getQuerySnapshot();
          },
          flTitlesData: FlTitlesData(
            bottomTitles: getBottomTitles(),
            leftTitles: getSideTitles(),
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    );
  }
}
