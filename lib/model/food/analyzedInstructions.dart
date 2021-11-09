import 'package:wecare_flutter/model/food/step.dart';

class AnalyzedInstructions {
  late String name;
  late List<Steps> steps;

  AnalyzedInstructions({required this.name, required this.steps});

  AnalyzedInstructions.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['steps'] != null) {
      //steps = new List<Steps>();
      json['steps'].forEach((v) {
        steps.add(Steps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['steps'] = steps.map((v) => v.toJson()).toList();
    return data;
  }
}
