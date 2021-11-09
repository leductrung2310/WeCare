import 'package:wecare_flutter/model/food/Temperature.dart';

class Equipment {
  late int id;
  late String name;
  late String localizedName;
  late String image;
  late Temperature temperature;

  Equipment(
      {required this.id,
      required this.name,
      required this.localizedName,
      required this.image,
      required this.temperature});

  Equipment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localizedName'];
    image = json['image'];
    temperature = (json['temperature'] != null
        ? Temperature.fromJson(json['temperature'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['localizedName'] = localizedName;
    data['image'] = image;
    data['temperature'] = temperature.toJson();
    return data;
  }
}
