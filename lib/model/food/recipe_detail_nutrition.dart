class RecipeGoodNutrition {
  String? title;
  String? amount;
  bool? indented;
  //double? percentOfDailyNeeds;

  RecipeGoodNutrition({
    required this.title,
    required this.amount,
    required this.indented,
    //required this.percentOfDailyNeeds,
  });

  RecipeGoodNutrition.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
    indented = json['indented'];
    //percentOfDailyNeeds = json['percentOfDailyNeeds'];
  }
  RecipeGoodNutrition.toJson(Map<String, dynamic> json) {
    title = json['title'];
    amount = json['amount'];
    indented = json['indented'];
    //percentOfDailyNeeds = json['percentOfDailyNeeds'];
  }
}
