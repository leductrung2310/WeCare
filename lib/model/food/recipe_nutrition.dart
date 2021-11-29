import 'package:wecare_flutter/model/food/recipe_detail_nutrition.dart';

class RecipeNutrition {
  String? calories;
  String? carbs;
  String? fat;
  String? protein;
  List<RecipeGoodNutrition>? good;
  List<RecipeGoodNutrition>? bad;
  RecipeNutrition({
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.protein,
    required this.good,
    required this.bad,
  });

  RecipeNutrition.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    carbs = json['carbs'];
    fat = json['fat'];
    protein = json['protein'];
    var list = json['good'] as List;
    List<RecipeGoodNutrition> imagesList =
        list.map((i) => RecipeGoodNutrition.fromJson(i)).toList();
    good = imagesList;
    var badlist = json['bad'] as List;
    List<RecipeGoodNutrition> getbadList =
        badlist.map((i) => RecipeGoodNutrition.fromJson(i)).toList();
    bad = getbadList;
  }
}
