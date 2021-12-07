import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/statistic_data/water_statistic_data.dart';
import 'package:wecare_flutter/screen/home/water/components/water_bar_chart_title.dart';
import 'package:wecare_flutter/screen/home/water/widgets/animated_chart.dart';
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

    List waterHisList = waterViewModel.getWaterHistoryList;

    WaterData? waterDataM;
    WaterData? waterDataT;
    WaterData? waterDataW;
    WaterData? waterDataTh;
    WaterData? waterDataF;
    WaterData? waterDataS;
    WaterData? waterDataSu;

    //! convert map to list
    if (waterHisList.isNotEmpty) {
      waterDataM = WaterData.fromDocument(waterHisList[0]);
      waterDataT = WaterData.fromDocument(waterHisList[1]);
      // waterDataW = WaterData.fromDocument(waterHisList[2]);
      // waterDataTh = WaterData.fromDocument(waterHisList[3]);
      // waterDataF = WaterData.fromDocument(waterHisList[4]);
      // waterDataS = WaterData.fromDocument(waterHisList[5]);
      // waterDataSu = WaterData.fromDocument(waterHisList[6]);
    }

    for (int i = 0; i < waterHisList.length; i++) {}

    List<WaterStatisticData> waterBarData = [
      WaterStatisticData(0, 'M', waterDataM?.waterIndex ?? 0, waterColor),
      WaterStatisticData(1, 'T', waterDataT?.waterIndex ?? 0, waterColor),
      WaterStatisticData(2, 'W', waterDataW?.waterIndex ?? 0, waterColor),
      WaterStatisticData(3, 'T', waterDataTh?.waterIndex ?? 0, waterColor),
      WaterStatisticData(4, 'F', waterDataF?.waterIndex ?? 0, waterColor),
      WaterStatisticData(5, 'S', waterDataS?.waterIndex ?? 0, waterColor),
      WaterStatisticData(6, 'S', waterDataSu?.waterIndex ?? 0, waterColor),
    ];

    List<BarChartGroupData> waterBarChartList = waterBarData
        .map(
          (WaterStatisticData data) => BarChartGroupData(
            x: data.id,
            barRods: [
              BarChartRodData(
                y: data.y,
                width: SizeConfig.blockSizeH! * 2.5,
                colors: [data.color],
              ),
            ],
          ),
        )
        .toList();

    return Align(
      alignment: Alignment.topCenter,
      child: ChangeNotifierProvider(
        create: (context) => WeeklyCalendarVM(),
        child: AnimatedChart(
          onPressed1: () {},
          onPressed2: () {},
          color: waterColor,
          barWidth: sizeH * 4,
          width: sizeH * 90,
          height: sizeV * 45,
          barChartGroupData: waterBarChartList,
          flTitlesData: FlTitlesData(
            bottomTitles: WaterBarTitles.getBottomTitles(),
            leftTitles: WaterBarTitles.getSideTitles(),
            topTitles: SideTitles(showTitles: false),
            rightTitles: SideTitles(showTitles: false),
          ),
        ),
      ),
    );
  }
}
