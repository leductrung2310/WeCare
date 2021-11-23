import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/model/food/recipe_nutrition.dart';
import 'package:wecare_flutter/model/food/recipes.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/food/widgets/food_detail_card_image.dart';
import 'package:wecare_flutter/screen/food/widgets/food_detail_ingredients.dart';
import 'package:wecare_flutter/view_model/food_view_model.dart';

class FoodDetailScreene extends StatelessWidget {
  final Recipes arguments;
  const FoodDetailScreene({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final foodViewModel = Provider.of<FoodViewModel>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F8FE),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: sizeH * 5.5, vertical: sizeV * 1.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  color: Colors.black,
                  onPressed: () => Navigator.of(context).pop(),
                  // onPressed: () {
                  //   print(arguments.instructions!);
                  // },
                ),
                Text(
                  arguments.title!,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: sizeH * 6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CardImageFood(
                  image: arguments.image!,
                  protein: foodViewModel.recipeNutrition.protein,
                  carbo: foodViewModel.recipeNutrition.carbs,
                  fat: foodViewModel.recipeNutrition.fat,
                  calo: foodViewModel.recipeNutrition.calories,
                ),
                Text(
                  "Ingredients",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: sizeH * 6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Wrap(
                  children: [
                    for (var item in arguments.extendedIngredients!)
                      Ingredient(
                        image: item.image!,
                        name: item.name!,
                        unit: removeDecimalZeroFormat(item.amount!) +
                            " " +
                            item.unit!,
                      ),
                  ],
                ),
                Text(
                  "Preparation",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: sizeH * 6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Html(
                  data: arguments.instructions!,
                  style: {
                    'li': Style(
                        fontSize: FontSize.larger,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        margin: EdgeInsets.symmetric(vertical: sizeV)),
                    'body': Style(
                        fontSize: FontSize.larger,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        margin: EdgeInsets.symmetric(vertical: sizeV)),
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }
}
