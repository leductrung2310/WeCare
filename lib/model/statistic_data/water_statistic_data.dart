import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wecare_flutter/constants/firestore_constants.dart';
class WaterData {
  double waterIndex = 0;
  int drinkTimes = 0;
  int id = 0;

  WaterData({
    required this.waterIndex,
    required this.drinkTimes,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return {
      FireStoreConstants.waterIndex: waterIndex,
      FireStoreConstants.drinkTimes: drinkTimes,
      FireStoreConstants.id: id,
    };
  }

  factory WaterData.fromDocument(DocumentSnapshot doc) {
    return WaterData(
      waterIndex: doc[FireStoreConstants.waterIndex],
      drinkTimes: doc[FireStoreConstants.drinkTimes],
      id: doc[FireStoreConstants.id],
    );
  }

  factory WaterData.fromMap(map) {
    return WaterData(
      waterIndex: map[FireStoreConstants.waterIndex],
      drinkTimes: map[FireStoreConstants.drinkTimes],
      id: map[FireStoreConstants.id],
    );
  }
}

class WaterStatisticData {
  int id;
  String name;

  WaterStatisticData({required this.id, required this.name});
}

class WaterDetailedStatisticData {
  final double index;
  final String unit;
  final String title;

  WaterDetailedStatisticData({
    required this.index,
    required this.unit,
    required this.title,
  });
}

class WaterCompleteChainData {
  final double percentage;
  final String dayOfWeek;

  WaterCompleteChainData({
    required this.percentage,
    required this.dayOfWeek,
  });
}
