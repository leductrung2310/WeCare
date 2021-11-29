import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:wecare_flutter/model/food/recipe_detail_nutrition.dart';
import 'package:wecare_flutter/model/food/recipe_detail_nutrition_list.dart';
import 'package:http/http.dart' as http;

class FoodDetailViewModel extends ChangeNotifier {
  bool _checkIconShow = true;

  get checkIconShow => _checkIconShow;
  set checkIconShow(value) {
    _checkIconShow = value;
    notifyListeners();
  }

  RecipeGoodNutritionList parseRecipeGoodNutritionList(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return RecipeGoodNutritionList.fromJson(parsed);
  }

  Future<RecipeGoodNutritionList> getFoodRecommendDiet() async {
    List<RecipeGoodNutrition> list = [];
    RecipeGoodNutritionList listRecipeGoodNutritionList =
        RecipeGoodNutritionList(recipeGoodNutrition: list);
    final response = await http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/random?number=2&tags=vegetarian,diets&apiKey=11447f4c188241fe8f71e29a79aae712'),
    );
    if (response.statusCode == 200) {
      return parseRecipeGoodNutritionList(response.body);
    } else {
      return listRecipeGoodNutritionList;
    }
  }
}
