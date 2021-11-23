class RecipeNutrition {
  late String calories;
  late String carbs;
  late String fat;
  late String protein;

  RecipeNutrition({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
  });

  RecipeNutrition.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    protein = json['protein'];
  }
}
