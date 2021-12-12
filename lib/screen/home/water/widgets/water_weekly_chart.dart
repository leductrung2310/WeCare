import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
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

    double interval = authenticService.getDesiredAmount % 2 == 0 ? 0.4 : 0.5;

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
        interval: interval,
        reservedSize: 30,
        getTitles: (double value) => value == 0 ? '0' : '${value}L',
      );
    }

    List indexesList = waterViewModel.getWaterHistoryList
        .map((data) => data.waterIndex)
        .toList();
    List sampleIndexesList = [0, 0, 0, 0, 0, 0, 0];

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

    Widget emptyWidget() {
      return Column(
        children: [
          Image.asset(
            'assets/images/home/water/empty.png',
            height: sizeV * 27,
            width: sizeH * 85,
          ),
          Text(
            "There's nothing here!",
            style: TextStyle(
              fontFamily: 'poppins',
              fontWeight: FontWeight.w500,
              fontSize: sizeV * 2.5,
              color: lightBlack,
            ),
          ),
        ],
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: ChangeNotifierProvider(
        create: (context) => WeeklyCalendarVM(),
        child: AnimatedChart(
          onPressed1: () async {
            await waterViewModel.getQuerySnapshot(-1);
            await waterViewModel.calculateAverage(context);
          },
          onPressed2: () async {
            await waterViewModel.getQuerySnapshot(1);
            await waterViewModel.calculateAverage(context);
          },
          color: waterColor,
          barWidth: sizeH * 4,
          width: sizeH * 90,
          height: sizeV * 45,
          barChartGroupData: waterBarChartList,
          flTitlesData: FlTitlesData(
            bottomTitles: getBottomTitles(),
            leftTitles: getSideTitles(),
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
          ),
          isEmptyData: listEquals(indexesList, sampleIndexesList),
          widget: emptyWidget(),
        ),
      ),
    );
  }
}
