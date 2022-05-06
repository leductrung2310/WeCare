class ExtendedIngredients {
  int? id;
  String? image;
  String? name;
  double? amount;
  String? unit;

  ExtendedIngredients(
      {required this.id,
      required this.image,
      required this.name,
      required this.amount,
      required this.unit});

  ExtendedIngredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    amount = json['amount'];
    unit = json['unit'];
  }
}
