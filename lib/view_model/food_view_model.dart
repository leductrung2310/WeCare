import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wecare_flutter/model/food/food.dart';
import 'package:wecare_flutter/model/food/list_recipes.dart';
import 'package:wecare_flutter/model/food/recipe_nutrition.dart';
import 'package:wecare_flutter/model/food/recipes.dart';

class FoodViewModel extends ChangeNotifier {
  //final List<String> _listFood = ['banana', 'appple', 'cut', 'orange'];
  List<String> _listFoodSearchHistory = [];
  String _search = 'search';

  late ListRecipes _listRecipes;
  late RecipeNutrition _recipeNutrition;
  late ListRecipes _listRecipesDessert;

  List<String> get listFoodSearchHistory => _listFoodSearchHistory;
  set listFoodSearchHistory(value) {
    _listFoodSearchHistory = value;
  }

  get stringSearch => _search;
  set stringSearch(value) {
    _search = value;
    notifyListeners();
  }

  ListRecipes get listRecipes => _listRecipes;
  set listRecipes(value) {
    _listRecipes = value;
    notifyListeners();
  }

  ListRecipes get listRecipesDessert => _listRecipesDessert;
  set listRecipesDessert(value) {
    _listRecipesDessert = value;
    notifyListeners();
  }

  List<String> searchFood(String query) {
    List<String> _result = [];
    if (query.isEmpty || query == "search") {
      return _listFoodSearchHistory;
    } else {
      return _result;
    }
  }

  // void runFilter(String query) {
  //   List<String> results = [];
  //   if (query.isEmpty || query == 'search') {
  //     results = _listFood;
  //   } else {
  //     results = _listFood
  //         .where((user) => user.toLowerCase().contains(query.toLowerCase()))
  //         .toList();
  //   }
  //   _listSearchFood = results;
  // }

  RecipeNutrition get recipeNutrition => _recipeNutrition;

  set recipeNutrition(value) {
    _recipeNutrition = value;
    notifyListeners();
  }

  List<Food> parseFood(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed.map<Food>((json) => Food.fromJson(json)).toList();
  }

  Future<List<Food>> getFoodNutrition(value) async {
    List<Food> list = [];
    final response = await http.get(
      Uri.parse('https://api.api-ninjas.com/v1/nutrition?query=' + value),
      headers: {
        'X-Api-Key': 'SxLuhBuEbJ8iDvFG+NMnOQ==b6O4n1I6co3bX2av',
      },
    );
    if (response.statusCode == 200) {
      return parseFood(response.body);
    } else {
      return list;
    }
  }

  ListRecipes parseRecipes(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return ListRecipes.fromJson(parsed);
  }

  Future<ListRecipes> getFoodRecommendDiet() async {
    List<Recipes> list = [];
    ListRecipes listRecipes = ListRecipes(recipes: list);
    final response = await http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/random?number=2&tags=vegetarian,diets&apiKey=71b9c284964f4d749ee3efbab13fad1d'),
    );
    if (response.statusCode == 200) {
      return parseRecipes(response.body);
    } else {
      return listRecipes;
    }
  }
  //11447f4c188241fe8f71e29a79aae712
  //71b9c284964f4d749ee3efbab13fad1d

  void setListRecipes() async {
    listRecipes = await getFoodRecommendDiet();
    notifyListeners();
  }

  Future<ListRecipes> getFoodRecommendDessert() async {
    List<Recipes> list = [];
    ListRecipes listRecipes = ListRecipes(recipes: list);
    final response = await http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/random?number=2&tags=dessert&apiKey=71b9c284964f4d749ee3efbab13fad1d'),
    );
    if (response.statusCode == 200) {
      return parseRecipes(response.body);
    } else {
      return listRecipes;
    }
  }

  void setListRecipesPopular() async {
    _listRecipesDessert = await getFoodRecommendDessert();
    notifyListeners();
  }

  //Recipe Nutrition
  RecipeNutrition parseRecipeNutrition(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return RecipeNutrition.fromJson(parsed);
  }

  Future<RecipeNutrition> getRecipeNutrition(value) async {
    RecipeNutrition recipeNutrition =
        RecipeNutrition(calories: "", carbs: "", fat: "", protein: "");
    final response = await http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/$value/nutritionWidget.json?apiKey=11447f4c188241fe8f71e29a79aae712'),
    );
    if (response.statusCode == 200) {
      return parseRecipeNutrition(response.body);
    } else {
      return recipeNutrition;
    }
  }
}
