import 'package:wecare_flutter/model/food/Temperature.dart';
import 'package:wecare_flutter/model/food/equipment.dart';
import 'package:wecare_flutter/model/food/ingredients.dart';

class Steps {
  late int number;
  late String step;
  late List<Ingredients> ingredients;
  late List<Equipment> equipment;
  late Temperature length;

  Steps(
      {required this.number,
      required this.step,
      required this.ingredients,
      required this.equipment,
      required this.length});

  Steps.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    step = json['step'];
    if (json['ingredients'] != null) {
      //ingredients = List<Ingredients>();
      json['ingredients'].forEach((v) {
        ingredients.add(Ingredients.fromJson(v));
      });
    }
    if (json['equipment'] != null) {
      //equipment = List<Equipment>();
      json['equipment'].forEach((v) {
        equipment.add(Equipment.fromJson(v));
      });
    }
    length =
        (json['length'] != null ? Temperature.fromJson(json['length']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['step'] = step;
    data['ingredients'] = ingredients.map((v) => v.toJson()).toList();
    data['equipment'] = equipment.map((v) => v.toJson()).toList();
    data['length'] = length.toJson();
    return data;
  }
}
