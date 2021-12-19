import 'package:wecare_flutter/model/food/extendedIngredients.dart';

class Recipes {
  late bool vegetarian;
  late bool vegan;
  late bool glutenFree;
  late bool dairyFree;
  late bool veryHealthy;
  late bool cheap;
  late bool veryPopular;
  late bool sustainable;
  late double healthScore;
  late double pricePerServing;
  late List<ExtendedIngredients>? extendedIngredients;
  late int id;
  late String title;
  late int readyInMinutes;
  late int servings;
  late String image;
  late String summary;
  late String instructions;

  Recipes({
    required this.vegetarian,
    required this.vegan,
    required this.glutenFree,
    required this.dairyFree,
    required this.veryHealthy,
    required this.cheap,
    required this.veryPopular,
    required this.sustainable,
    required this.healthScore,
    required this.pricePerServing,
    required this.extendedIngredients,
    required this.id,
    required this.title,
    required this.readyInMinutes,
    required this.servings,
    required this.image,
    required this.summary,
    required this.instructions,
  });

  Recipes.fromJson(Map<String, dynamic> json) {
    vegetarian = json['vegetarian'];
    vegan = json['vegan'];
    glutenFree = json['glutenFree'];
    dairyFree = json['dairyFree'];
    veryHealthy = json['veryHealthy'];
    cheap = json['cheap'];
    veryPopular = json['veryPopular'];
    sustainable = json['sustainable'];
    healthScore = json['healthScore'];
    pricePerServing = json['pricePerServing'];
    var list = json['extendedIngredients'] as List;
    List<ExtendedIngredients> imagesList =
        list.map((i) => ExtendedIngredients.fromJson(i)).toList();
    extendedIngredients = imagesList;
    id = json['id'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    image = json['image'];
    summary = json['summary'];
    if (json['cuisines'] != null) {
      json['cuisines'].forEach((v) {});
    }
    if (json['occasions'] != null) {
      json['occasions'].forEach((v) {});
    }
    instructions = json['instructions'];
  }
}
