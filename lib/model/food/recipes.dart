// ignore_for_file: void_checks

import 'package:wecare_flutter/model/food/analyzedInstructions.dart';
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
  late int weightWatcherSmartPoints;
  late String gaps;
  late bool lowFodmap;
  late int aggregateLikes;
  late int spoonacularScore;
  late int healthScore;
  late String creditsText;
  late String license;
  late String sourceName;
  late double pricePerServing;
  late List<ExtendedIngredients> extendedIngredients;
  late int id;
  late String title;
  late int readyInMinutes;
  late int servings;
  late String sourceUrl;
  late String image;
  late String imageType;
  late String summary;
  late List<Null> cuisines;
  late List<String> dishTypes;
  late List<String> diets;
  late List<Null> occasions;
  late String instructions;
  late List<AnalyzedInstructions> analyzedInstructions;
  late void originalId;
  late String spoonacularSourceUrl;

  Recipes(
      {required this.vegetarian,
      required this.vegan,
      required this.glutenFree,
      required this.dairyFree,
      required this.veryHealthy,
      required this.cheap,
      required this.veryPopular,
      required this.sustainable,
      required this.weightWatcherSmartPoints,
      required this.gaps,
      required this.lowFodmap,
      required this.aggregateLikes,
      required this.spoonacularScore,
      required this.healthScore,
      required this.creditsText,
      required this.license,
      required this.sourceName,
      required this.pricePerServing,
      required this.extendedIngredients,
      required this.id,
      required this.title,
      required this.readyInMinutes,
      required this.servings,
      required this.sourceUrl,
      required this.image,
      required this.imageType,
      required this.summary,
      required this.cuisines,
      required this.dishTypes,
      required this.diets,
      required this.occasions,
      required this.instructions,
      required this.analyzedInstructions,
      required this.originalId,
      required this.spoonacularSourceUrl});

  Recipes.fromJson(Map<String, dynamic> json) {
    vegetarian = json['vegetarian'];
    vegan = json['vegan'];
    glutenFree = json['glutenFree'];
    dairyFree = json['dairyFree'];
    veryHealthy = json['veryHealthy'];
    cheap = json['cheap'];
    veryPopular = json['veryPopular'];
    sustainable = json['sustainable'];
    weightWatcherSmartPoints = json['weightWatcherSmartPoints'];
    gaps = json['gaps'];
    lowFodmap = json['lowFodmap'];
    aggregateLikes = json['aggregateLikes'];
    spoonacularScore = json['spoonacularScore'];
    healthScore = json['healthScore'];
    creditsText = json['creditsText'];
    license = json['license'];
    sourceName = json['sourceName'];
    pricePerServing = json['pricePerServing'];
    if (json['extendedIngredients'] != null) {
      json['extendedIngredients'].forEach((v) {
        extendedIngredients.add(ExtendedIngredients.fromJson(v));
      });
    }
    id = json['id'];
    title = json['title'];
    readyInMinutes = json['readyInMinutes'];
    servings = json['servings'];
    sourceUrl = json['sourceUrl'];
    image = json['image'];
    imageType = json['imageType'];
    summary = json['summary'];
    if (json['cuisines'] != null) {
      json['cuisines'].forEach((v) {});
    }
    dishTypes = json['dishTypes'].cast<String>();
    diets = json['diets'].cast<String>();
    if (json['occasions'] != null) {
      json['occasions'].forEach((v) {});
    }
    instructions = json['instructions'];
    if (json['analyzedInstructions'] != null) {
      json['analyzedInstructions'].forEach((v) {
        analyzedInstructions.add(AnalyzedInstructions.fromJson(v));
      });
    }
    originalId = json['originalId'];
    spoonacularSourceUrl = json['spoonacularSourceUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['vegetarian'] = vegetarian;
    data['vegan'] = vegan;
    data['glutenFree'] = glutenFree;
    data['dairyFree'] = dairyFree;
    data['veryHealthy'] = veryHealthy;
    data['cheap'] = cheap;
    data['veryPopular'] = veryPopular;
    data['sustainable'] = sustainable;
    data['weightWatcherSmartPoints'] = weightWatcherSmartPoints;
    data['gaps'] = gaps;
    data['lowFodmap'] = lowFodmap;
    data['aggregateLikes'] = aggregateLikes;
    data['spoonacularScore'] = spoonacularScore;
    data['healthScore'] = healthScore;
    data['creditsText'] = creditsText;
    data['license'] = license;
    data['sourceName'] = sourceName;
    data['pricePerServing'] = pricePerServing;
    if (extendedIngredients != null) {
      data['extendedIngredients'] =
          extendedIngredients.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['title'] = title;
    data['readyInMinutes'] = readyInMinutes;
    data['servings'] = servings;
    data['sourceUrl'] = sourceUrl;
    data['image'] = image;
    data['imageType'] = imageType;
    data['summary'] = summary;
    data['dishTypes'] = dishTypes;
    data['diets'] = diets;
    data['instructions'] = instructions;
    data['analyzedInstructions'] =
        analyzedInstructions.map((v) => v.toJson()).toList();
    data['spoonacularSourceUrl'] = spoonacularSourceUrl;
    return data;
  }
}
