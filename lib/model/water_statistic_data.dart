import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class WaterStatisticData {
  final int id;
  final String name;
  final double y;
  final Color color;

  const WaterStatisticData({
    required this.id,
    required this.name,
    required this.y,
    required this.color,
  });
}

class WaterBarData {
  static double interval = 0.5;

  static List<WaterStatisticData> waterBarData = [
    const WaterStatisticData(
      id: 0,
      name: 'M',
      y: 1.8,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 1,
      name: 'T',
      y: 1.5,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 2,
      name: 'W',
      y: 2,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 3,
      name: 'T',
      y: 1.4,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 4,
      name: 'F',
      y: 1.8,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 5,
      name: 'S',
      y: 2.2,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 6,
      name: 'S',
      y: 2,
      color: waterColor,
    ),
  ];
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
