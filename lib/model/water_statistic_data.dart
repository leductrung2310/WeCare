import 'package:flutter/cupertino.dart';
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
      name: 'Mon',
      y: 1.8,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 1,
      name: 'Tue',
      y: 1.5,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 2,
      name: 'Wed',
      y: 2,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 3,
      name: 'Thu',
      y: 1.4,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 4,
      name: 'Fri',
      y: 1.8,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 5,
      name: 'Sat',
      y: 2.2,
      color: waterColor,
    ),
    const WaterStatisticData(
      id: 6,
      name: 'Sun',
      y: 2,
      color: waterColor,
    ),
  ];
}
