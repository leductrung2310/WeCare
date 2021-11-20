import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/food/widgets/food_recommend.dart';
import 'package:wecare_flutter/screen/food/widgets/food_recommend_popular.dart';
import 'package:wecare_flutter/screen/food/widgets/food_search.dart';
import 'package:wecare_flutter/view_model/food_view_model.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final foodViewModel = Provider.of<FoodViewModel>(context, listen: false);
    //foodViewModel.setListRecipes();

    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sizeV * 2.5,
              ),
              Stack(
                children: [
                  Positioned(
                    top: 90,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(sizeV * 4.5),
                          topRight: Radius.circular(sizeV * 4.5),
                        ),
                        color: whiteColor,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.only(top: sizeH * 4, left: sizeH * 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: sizeV,
                            ),
                            Text(
                              "Recommandation\nfor vegetarian",
                              style: style,
                            ),
                            SizedBox(
                              height: sizeV,
                            ),
                            SizedBox(
                              height: sizeV * 32,
                              child: ListView.builder(
                                itemCount: 1,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    children: [
                                      FoodRecommend(
                                        cardColor: const Color(0xFFEBF2FF),
                                        colorOne: const Color(0xFF92A3FD),
                                        colorTwo: const Color(0xFF9DCEFF),
                                        // nameRecipe: "",
                                        // descriptionRecipe: '',
                                        // image: '',
                                        nameRecipe: foodViewModel
                                            .listRecipes.recipes[0].title!,
                                        descriptionRecipe:
                                            '${foodViewModel.listRecipes.recipes[0].readyInMinutes.toString()} mins | ${foodViewModel.listRecipes.recipes[0].servings.toString()} serves',
                                        image: foodViewModel
                                            .listRecipes.recipes[0].image!,
                                        onTapp: () async {
                                          await getRecipeNutrition(
                                              foodViewModel,
                                              foodViewModel
                                                  .listRecipes.recipes[0].id);
                                          final recipe = foodViewModel
                                              .listRecipes.recipes[0];

                                          Navigator.pushNamed(
                                              context, Routes.foodDetailScreen,
                                              arguments: recipe);
                                        },
                                      ),
                                      SizedBox(
                                        width: sizeH * 5,
                                      ),
                                      FoodRecommend(
                                        cardColor: const Color(0xFFF9EBF8),
                                        colorOne: const Color(0xFFC58BF2),
                                        colorTwo: const Color(0xFFEEA4CE),
                                        nameRecipe: foodViewModel
                                            .listRecipes.recipes[1].title!,
                                        descriptionRecipe:
                                            '${foodViewModel.listRecipes.recipes[1].readyInMinutes.toString()} mins | ${foodViewModel.listRecipes.recipes[1].servings.toString()} serves',
                                        image: foodViewModel
                                            .listRecipes.recipes[1].image!,
                                        onTapp: () {},
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              height: sizeV * 2,
                            ),
                            Text(
                              "Dessert",
                              style: style,
                            ),
                            SizedBox(
                              height: sizeV,
                            ),
                            FoodRecommendPopular(
                              nameRecipe: foodViewModel
                                  .listRecipesDessert.recipes[0].title!,
                              descriptionRecipe:
                                  '${foodViewModel.listRecipesDessert.recipes[0].readyInMinutes.toString()} mins | ${foodViewModel.listRecipesDessert.recipes[0].servings.toString()} serves',
                              image: foodViewModel
                                  .listRecipesDessert.recipes[0].image!,
                              onTapp: () async {
                                await getRecipeNutrition(
                                    foodViewModel,
                                    foodViewModel
                                        .listRecipesDessert.recipes[0].id);
                                final recipe =
                                    foodViewModel.listRecipesDessert.recipes[0];

                                Navigator.pushNamed(
                                    context, Routes.foodDetailScreen,
                                    arguments: recipe);
                              },
                            ),
                            FoodRecommendPopular(
                              nameRecipe: foodViewModel
                                  .listRecipesDessert.recipes[1].title!,
                              descriptionRecipe:
                                  '${foodViewModel.listRecipesDessert.recipes[1].readyInMinutes.toString()} mins | ${foodViewModel.listRecipesDessert.recipes[1].servings.toString()} serves',
                              image: foodViewModel
                                  .listRecipesDessert.recipes[1].image!,
                              onTapp: () async {
                                await getRecipeNutrition(
                                    foodViewModel,
                                    foodViewModel
                                        .listRecipesDessert.recipes[1].id);
                                final recipe =
                                    foodViewModel.listRecipesDessert.recipes[1];

                                Navigator.pushNamed(
                                    context, Routes.foodDetailScreen,
                                    arguments: recipe);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        height: sizeV * 100,
                        width: sizeH * 95,
                        child: const SearchBarCustom()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getRecipeNutrition(
      FoodViewModel foodViewModel, int idRecipe) async {
    foodViewModel.recipeNutrition =
        await foodViewModel.getRecipeNutrition(idRecipe);
  }

  // void setListRecipes(FoodViewModel foodViewModel) async {
  //   foodViewModel.listRecipes = await foodViewModel.getFoodRecommendDiet();
  //   print(foodViewModel.listRecipes.recipes[0].title!);
  // }
}

final style = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 4.4,
  fontFamily: "Poppins",
  fontWeight: FontWeight.w600,
);
