class Food {
  late String name;
  late double calories;
  late double servingSizeG;
  late double fatTotalG;
  late double fatSaturatedG;
  late double proteinG;
  late int sodiumMg;
  late int potassiumMg;
  late int cholesterolMg;
  late double carbohydratesTotalG;
  late double fiberG;
  late double sugarG;

  Food(
      {required this.name,
      required this.calories,
      required this.servingSizeG,
      required this.fatTotalG,
      required this.fatSaturatedG,
      required this.proteinG,
      required this.sodiumMg,
      required this.potassiumMg,
      required this.cholesterolMg,
      required this.carbohydratesTotalG,
      required this.fiberG,
      required this.sugarG});

  Food.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    calories = json['calories'];
    servingSizeG = json['serving_size_g'];
    fatTotalG = json['fat_total_g'];
    fatSaturatedG = json['fat_saturated_g'];
    proteinG = json['protein_g'];
    sodiumMg = json['sodium_mg'];
    potassiumMg = json['potassium_mg'];
    cholesterolMg = json['cholesterol_mg'];
    carbohydratesTotalG = json['carbohydrates_total_g'];
    fiberG = json['fiber_g'];
    sugarG = json['sugar_g'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['calories'] = calories;
    data['serving_size_g'] = servingSizeG;
    data['fat_total_g'] = fatTotalG;
    data['fat_saturated_g'] = fatSaturatedG;
    data['protein_g'] = proteinG;
    data['sodium_mg'] = sodiumMg;
    data['potassium_mg'] = potassiumMg;
    data['cholesterol_mg'] = cholesterolMg;
    data['carbohydrates_total_g'] = carbohydratesTotalG;
    data['fiber_g'] = fiberG;
    data['sugar_g'] = sugarG;
    return data;
  }
}
