class Metric {
  late double amount;
  late String unitShort;
  late String unitLong;

  Metric(
      {required this.amount, required this.unitShort, required this.unitLong});

  Metric.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    unitShort = json['unitShort'];
    unitLong = json['unitLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['unitShort'] = unitShort;
    data['unitLong'] = unitLong;
    return data;
  }
}
