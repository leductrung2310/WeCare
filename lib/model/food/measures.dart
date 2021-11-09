import 'package:wecare_flutter/model/food/metric.dart';
import 'package:wecare_flutter/model/food/us.dart';

class Measures {
  late Us us;
  late Metric metric;

  Measures({required this.us, required this.metric});

  Measures.fromJson(Map<String, dynamic> json) {
    us = (json['us'] != null ? Us.fromJson(json['us']) : null)!;
    metric = (json['metric'] != null ? Metric.fromJson(json['metric']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['us'] = us.toJson();
    data['metric'] = metric.toJson();
    return data;
  }
}
