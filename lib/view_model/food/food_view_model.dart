import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:wecare_flutter/model/food/food.dart';
import 'package:wecare_flutter/model/food/list_recipes.dart';
import 'package:wecare_flutter/model/food/nutrition_history.dart';
import 'package:wecare_flutter/model/food/recipe_nutrition.dart';
import 'package:wecare_flutter/model/food/recipes.dart';

class FoodViewModel extends ChangeNotifier {
  final List<String> _listFood = ['banana', 'appple', 'cut', 'orange'];
  List<String> _listNutritionHistoryLocal = [];
  List<String> get listFood => _listFood;
  String _search = 'search';

  bool _checkLoadFoodPopular = false;
  bool _checkLoadFoodDessert = false;
  get checkLoadFoodPopular => _checkLoadFoodPopular;
  set checkLoadFoodPopular(value) {
    _checkLoadFoodPopular = value;
  }

  get checkLoadFoodDessert => _checkLoadFoodDessert;
  set checkLoadFoodDessert(value) {
    _checkLoadFoodDessert = value;
  }

  NutritionHistory _listNutritionHistory = NutritionHistory(
    nutrition1: '1',
    nutrition2: '2',
    nutrition3: '3',
    nutrition4: '4',
    nutrition5: '5',
  );

  late ListRecipes _listRecipes;
  late RecipeNutrition _recipeNutrition;
  late ListRecipes _listRecipesDessert;

  List<String> get listNutritionHistoryLocal => _listNutritionHistoryLocal;
  set listNutritionHistoryLocal(value) {
    _listNutritionHistoryLocal = value;
  }

  NutritionHistory get listNutritionHistory => _listNutritionHistory;
  set listNutritionHistory(value) {
    _listNutritionHistory = value;
  }

  void getNutritionHistoryList(String uid) async {
    await FirebaseFirestore.instance
        .collection('foodHistory')
        .doc(uid)
        .get()
        .then(
      (value) {
        if (value.data() != null) {
          _listNutritionHistory = NutritionHistory.fromMap(value.data()!);
        }
      },
    );
    _listNutritionHistoryLocal.clear();
    if (_listNutritionHistory.nutrition1 == '') {
    } else {
      if (_listNutritionHistory.nutrition2 == '') {
        _listNutritionHistoryLocal
            .add(_listNutritionHistory.nutrition1 ?? 'No data');
      } else {
        if (_listNutritionHistory.nutrition3 == '') {
          _listNutritionHistoryLocal
              .add(_listNutritionHistory.nutrition1 ?? 'No data');
          _listNutritionHistoryLocal
              .add(_listNutritionHistory.nutrition2 ?? '');
        } else {
          if (_listNutritionHistory.nutrition4 == '') {
            _listNutritionHistoryLocal
                .add(_listNutritionHistory.nutrition1 ?? '');
            _listNutritionHistoryLocal
                .add(_listNutritionHistory.nutrition2 ?? 'No data');
            _listNutritionHistoryLocal
                .add(_listNutritionHistory.nutrition3 ?? 'No data');
          } else {
            if (_listNutritionHistory.nutrition5 == '') {
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition1 ?? 'No data');
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition2 ?? 'No data');
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition3 ?? 'No data');
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition4 ?? 'No data');
            } else {
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition1 ?? 'No data');
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition2 ?? 'No data');
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition3 ?? 'No data');
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition4 ?? 'No data');
              _listNutritionHistoryLocal
                  .add(_listNutritionHistory.nutrition5 ?? 'No data');
            }
          }
        }
      }
    }
    notifyListeners();
  }

  void updateNutritionHistoryList(String uid, String nutrition) async {
    if (_listNutritionHistory.nutrition1! == '') {
      await FirebaseFirestore.instance
          .collection('foodHistory')
          .doc(uid)
          .update(
        {
          '1': nutrition,
        },
      );
    } else {
      if (_listNutritionHistory.nutrition2! == '') {
        await FirebaseFirestore.instance
            .collection('foodHistory')
            .doc(uid)
            .update(
          {
            '1': nutrition,
            '2': listNutritionHistoryLocal[0],
          },
        );
      } else {
        if (_listNutritionHistory.nutrition3! == '') {
          await FirebaseFirestore.instance
              .collection('foodHistory')
              .doc(uid)
              .update(
            {
              '1': nutrition,
              '2': listNutritionHistoryLocal[0],
              '3': listNutritionHistoryLocal[1],
            },
          );
        } else {
          if (_listNutritionHistory.nutrition4! == '') {
            await FirebaseFirestore.instance
                .collection('foodHistory')
                .doc(uid)
                .update(
              {
                '1': nutrition,
                '2': listNutritionHistoryLocal[0],
                '3': listNutritionHistoryLocal[1],
                '4': listNutritionHistoryLocal[2],
              },
            );
          } else {
            if (_listNutritionHistory.nutrition5 == '') {
              await FirebaseFirestore.instance
                  .collection('foodHistory')
                  .doc(uid)
                  .update(
                {
                  '1': nutrition,
                  '2': listNutritionHistoryLocal[0],
                  '3': listNutritionHistoryLocal[1],
                  '4': listNutritionHistoryLocal[2],
                  '5': listNutritionHistoryLocal[3],
                },
              );
            } else {
              await FirebaseFirestore.instance
                  .collection('foodHistory')
                  .doc(uid)
                  .update(
                {
                  '1': nutrition,
                  '2': listNutritionHistoryLocal[0],
                  '3': listNutritionHistoryLocal[1],
                  '4': listNutritionHistoryLocal[2],
                  '5': listNutritionHistoryLocal[3],
                },
              );
            }
          }
        }
      }
    }
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

  List<String> runFilter() {
    List<String> results = [];
    if (_search.isEmpty || _search == 'search') {
      results = _listNutritionHistoryLocal;
    } else {
      results = _listNutritionHistoryLocal
          .where((item) => item.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    }
    return results;
  }

  RecipeNutrition get recipeNutrition => _recipeNutrition;

  set recipeNutrition(value) {
    _recipeNutrition = value;
    notifyListeners();
  }

  List<Food> parseFood(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Food>((json) => Food.fromJson(json)).toList();
  }

  //71b9c284964f4d749ee3efbab13fad1d
  //71b9c284964f4d749ee3efbab13fad1d

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

  void setListRecipes() async {
    listRecipes = await getFoodRecommendDiet();
    _checkLoadFoodPopular = true;
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
    _checkLoadFoodDessert = true;
    notifyListeners();
  }

  //Recipe Nutrition
  RecipeNutrition parseRecipeNutrition(String responseBody) {
    final parsed = jsonDecode(responseBody);
    return RecipeNutrition.fromJson(parsed);
  }

  Future<RecipeNutrition> getRecipeNutrition(value) async {
    RecipeNutrition? recipeNutrition;
    final response = await http.get(
      Uri.parse(
          'https://api.spoonacular.com/recipes/$value/nutritionWidget.json?apiKey=71b9c284964f4d749ee3efbab13fad1d'),
    );
    if (response.statusCode == 200) {
      return parseRecipeNutrition(response.body);
    } else {
      return recipeNutrition!;
    }
  }
}
