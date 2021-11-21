class ExtendedIngredients {
  late int id;
  // late String aisle;
  late String? image;
  // late String consistency;
  late String? name;
  // late String nameClean;
  // late String original;
  // late String originalString;
  // late String originalName;
  late double? amount;
  late String? unit;

  ExtendedIngredients(
      {required this.id,
      // required this.aisle,
      required this.image,
      // required this.consistency,
      required this.name,
      // required this.nameClean,
      // required this.original,
      // required this.originalString,
      // required this.originalName,
      required this.amount,
      required this.unit});

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // aisle = json['aisle'];
    image = json['image'];
    // consistency = json['consistency'];
    name = json['name'];
    // nameClean = json['nameClean'];
    // original = json['original'];
    // originalString = json['originalString'];
    // originalName = json['originalName'];
    amount = json['amount'];
    unit = json['unit'];
  }
}
