import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:http/http.dart' as http;
import 'package:wecare_flutter/model/food.dart';

class FoodViewModel extends ChangeNotifier {
  final List<String> _listFood = ['banana', 'appple', 'cut', 'orange'];
  List<String> _listSearchFood = [];
  List<String> _listFoodSearchHistory = [];

  List<String> searchFood(String query) {
    List<String> _result = [];
    if (query.isEmpty || query == "search") {
      print("1");
      return _listFoodSearchHistory;
    } else {
      _result = _listFood
          .where((user) => user.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (_result.isEmpty) {
        print("2");
        return _listFood;
      } else {
        print("3");
        return _result;
      }
    }
  }

  void runFilter(String query) {
    List<String> results = [];
    if (query.isEmpty || query == 'search') {
      results = _listFood;
    } else {
      results = _listFood
          .where((user) => user.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    _listSearchFood = results;
  }

  List<String> get listFood => _listFood;
  List<String> get listFoodSearchHistory => _listFoodSearchHistory;

  String _search = 'search';

  get stringSearch => _search;

  set stringSearch(value) {
    _search = value;
    notifyListeners();
  }

  List<Food> parseFood(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
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
      print(response.body);
      list = parseFood(response.body);
      print(list.length);
      print(list[0].name);
      print("list.length");
      return parseFood(response.body);
    } else {
      return list;
    }
  }
}
