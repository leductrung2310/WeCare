class Ingredients {
  late int id;
  late String name;
  late String localizedName;
  late String image;

  Ingredients(
      {required this.id,
      required this.name,
      required this.localizedName,
      required this.image});

  Ingredients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    localizedName = json['localizedName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['localizedName'] = localizedName;
    data['image'] = image;
    return data;
  }
}
