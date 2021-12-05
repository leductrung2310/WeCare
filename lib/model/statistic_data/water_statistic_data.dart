import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/constants/firestore_constants.dart';
import 'package:wecare_flutter/model/statistic_data/statistic_data.dart';

class WaterData {
  double waterIndex = 0;
  int drinkTimes = 0;

  WaterData({
    required this.waterIndex,
    required this.drinkTimes,
  });

  Map<String, dynamic> toJson() {
    return {
      FireStoreConstants.waterIndex: waterIndex,
      FireStoreConstants.drinkTimes: drinkTimes,
    };
  }

  factory WaterData.fromDocument(DocumentSnapshot doc) {
    return WaterData(
        waterIndex: doc[FireStoreConstants.waterIndex],
        drinkTimes: doc[FireStoreConstants.drinkTimes],
    );
  }
}

class WaterStatisticData extends StatticticData {
  WaterStatisticData(int id, String name, double y, Color color)
      : super(id, name, y, color);
}

class WaterBarData {
  static double interval = 0.5;

  static List<WaterStatisticData> waterBarData = [
    WaterStatisticData(0, 'M', 1.8, waterColor),
    WaterStatisticData(1, 'T', 1.5, waterColor),
    WaterStatisticData(2, 'W', 2, waterColor),
    WaterStatisticData(3, 'T', 1.4, waterColor),
    WaterStatisticData(4, 'F', 1.8, waterColor),
    WaterStatisticData(5, 'S', 2.2, waterColor),
    WaterStatisticData(6, 'S', 2, waterColor),
  ];

  static List<BarChartGroupData> waterBarChartList = waterBarData
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
}

class WaterDetailedStatisticData {
  final int index;
  final String unit;
  final String title;

  WaterDetailedStatisticData({
    required this.index,
    required this.unit,
    required this.title,
  });
}

List<WaterDetailedStatisticData> waterDetailedListData = [
  WaterDetailedStatisticData(index: 1300, unit: 'ml/day', title: 'Average'),
  WaterDetailedStatisticData(index: 67, unit: '%', title: 'Completed'),
  WaterDetailedStatisticData(index: 10, unit: 'times/day', title: 'Times'),
];

class WaterCompleteChainData {
  final double percentage;
  final String dayOfWeek;

  WaterCompleteChainData({
    required this.percentage,
    required this.dayOfWeek,
  });
}

List<WaterCompleteChainData> waterCompleteChainList = [
  WaterCompleteChainData(percentage: 60, dayOfWeek: 'Mon'),
  WaterCompleteChainData(percentage: 40, dayOfWeek: 'Tue'),
  WaterCompleteChainData(percentage: 100, dayOfWeek: 'Wed'),
  WaterCompleteChainData(percentage: 30, dayOfWeek: 'Thu'),
  WaterCompleteChainData(percentage: 70, dayOfWeek: 'Fri'),
  WaterCompleteChainData(percentage: 82, dayOfWeek: 'Sat'),
  WaterCompleteChainData(percentage: 95, dayOfWeek: 'Sun'),
];
