import 'package:wecare_flutter/model/food/recipes.dart';

class ListRecipes {
  late List<Recipes> recipes;

  ListRecipes({required this.recipes});

  ListRecipes.fromJson(Map<String, dynamic> json) {
    var list = json['recipes'] as List;
    List<Recipes> imagesList = list.map((i) => Recipes.fromJson(i)).toList();
    recipes = imagesList;
  }
}
