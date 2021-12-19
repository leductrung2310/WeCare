import 'package:wecare_flutter/model/food/recipe_detail_nutrition.dart';

class RecipeGoodNutritionList {
  late List<RecipeGoodNutrition> recipeGoodNutrition;

  RecipeGoodNutritionList({required this.recipeGoodNutrition});

  RecipeGoodNutritionList.fromJson(Map<String, dynamic> json) {
    var list = json['good'] as List;
    List<RecipeGoodNutrition> imagesList =
        list.map((i) => RecipeGoodNutrition.fromJson(i)).toList();
    recipeGoodNutrition = imagesList;
  }
}
