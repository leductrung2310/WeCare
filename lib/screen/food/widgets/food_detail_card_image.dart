import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/food/recipe_nutrition.dart';
import 'package:wecare_flutter/view_model/food/food_detail_view_model.dart';

class CardImageFood extends StatelessWidget {
  final String image;
  // final String protein;
  // final String carbo;
  // final String fat;
  // final String calo;
  final RecipeNutrition recipeNutrition;
  const CardImageFood({
    Key? key,
    required this.image,
    // required this.protein,
    // required this.carbo,
    // required this.fat,
    // required this.calo,
    required this.recipeNutrition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final foodDetailViewModel = Provider.of<FoodDetailViewModel>(context);

    return Container(
      width: sizeH * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sizeH * 4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cardImage(context, sizeH, sizeV),
          additionNutrition(context, sizeH, sizeV, foodDetailViewModel),
        ],
      ),
    );
  }

  cardImage(context, sizeH, sizeV) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeV * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: sizeH * 3,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: sizeH * 18,
          ),
          SizedBox(
            width: sizeH * 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                recipeNutrition.protein != null
                    ? recipeNutrition.protein!
                    : "1",
                style: styleOne,
              ),
              Text(
                "Protein",
                style: styleTwo,
              ),
              SizedBox(
                height: sizeV,
              ),
              Text(
                recipeNutrition.fat != null ? recipeNutrition.fat! : "1",
                style: styleOne,
              ),
              Text(
                "Fat",
                style: styleTwo,
              ),
            ],
          ),
          SizedBox(
            width: sizeH * 4,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                recipeNutrition.carbs != null ? recipeNutrition.carbs! : "1",
                style: styleOne,
              ),
              Text(
                "Carbo",
                style: styleTwo,
              ),
              SizedBox(
                height: sizeV,
              ),
              Text(
                recipeNutrition.calories != null
                    ? recipeNutrition.calories!
                    : "1",
                style: styleOne,
              ),
              Text(
                "Calories",
                style: styleTwo,
              ),
            ],
          ),
          IconButton(
            padding: EdgeInsets.zero,
            iconSize: 1,
            onPressed: () {
              Provider.of<FoodDetailViewModel>(context, listen: false)
                      .checkIconShow =
                  !Provider.of<FoodDetailViewModel>(context, listen: false)
                      .checkIconShow;
            },
            icon: Icon(
              Provider.of<FoodDetailViewModel>(context).checkIconShow
                  ? Icons.arrow_circle_down_sharp
                  : Icons.arrow_circle_up_sharp,
              size: sizeH * 8,
            ),
          ),
        ],
      ),
    );
  }

  additionNutrition(context, sizeH, sizeV, foodDetailViewModel) {
    return AnimatedContainer(
      width: sizeH * 80,
      height: foodDetailViewModel.checkIconShow ? 0 : sizeV * 85,
      alignment: foodDetailViewModel.checkIconShow
          ? Alignment.center
          : AlignmentDirectional.topCenter,
      duration: const Duration(seconds: 2),
      curve: Curves.fastLinearToSlowEaseIn,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: foodDetailViewModel.checkIconShow
            ? const SizedBox.shrink()
            : Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Nutrition',
                          style: styleOne,
                        ),
                        SizedBox(
                          height: sizeV * 85,
                          child: ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    for (var item in recipeNutrition.good!)
                                      Text(
                                        item.title!,
                                        style: styleThree,
                                      ),
                                    for (var item in recipeNutrition.bad!)
                                      Text(
                                        item.title!,
                                        style: styleThree,
                                      ),
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'Amount',
                          style: styleOne,
                        ),
                        SizedBox(
                          height: sizeV * 85,
                          child: ListView.builder(
                              itemCount: 1,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    for (var item in recipeNutrition.good!)
                                      Text(
                                        item.amount!,
                                        style: styleFour,
                                      ),
                                    for (var item in recipeNutrition.bad!)
                                      Text(
                                        item.amount!,
                                        style: styleFour,
                                      ),
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

final styleOne = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 4,
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);

final styleTwo = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 3,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);

final styleThree = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 3.5,
  fontWeight: FontWeight.w500,
  fontFamily: "Poppins",
);

final styleFour = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 3.5,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
