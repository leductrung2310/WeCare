import 'package:wecare_flutter/model/food/measures.dart';

class ExtendedIngredients {
  late int id;
  late String aisle;
  late String image;
  late String consistency;
  late String name;
  late String nameClean;
  late String original;
  late String originalString;
  late String originalName;
  late int amount;
  late String unit;
  late List<String> meta;
  late List<String> metaInformation;
  late Measures measures;

  ExtendedIngredients(
      {required this.id,
      required this.aisle,
      required this.image,
      required this.consistency,
      required this.name,
      required this.nameClean,
      required this.original,
      required this.originalString,
      required this.originalName,
      required this.amount,
      required this.unit,
      required this.meta,
      required this.metaInformation,
      required this.measures});

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    aisle = json['aisle'];
    image = json['image'];
    consistency = json['consistency'];
    name = json['name'];
    nameClean = json['nameClean'];
    original = json['original'];
    originalString = json['originalString'];
    originalName = json['originalName'];
    amount = json['amount'];
    unit = json['unit'];
    meta = json['meta'].cast<String>();
    metaInformation = json['metaInformation'].cast<String>();
    measures = (json['measures'] != null
        ? Measures.fromJson(json['measures'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['aisle'] = aisle;
    data['image'] = image;
    data['consistency'] = consistency;
    data['name'] = name;
    data['nameClean'] = nameClean;
    data['original'] = original;
    data['originalString'] = originalString;
    data['originalName'] = originalName;
    data['amount'] = amount;
    data['unit'] = unit;
    data['meta'] = meta;
    data['metaInformation'] = metaInformation;
    data['measures'] = measures.toJson();
    return data;
  }
}
