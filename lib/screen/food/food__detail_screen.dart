import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/food/widgets/food_detail_card_image.dart';
import 'package:wecare_flutter/screen/food/widgets/food_detail_ingredients.dart';

class FoodDetailScreene extends StatelessWidget {
  const FoodDetailScreene({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

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
                ),
                Text(
                  "Homemande",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: sizeH * 6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const CardImageFood(),
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
                    Ingredient(),
                    Ingredient(),
                    Ingredient(),
                    Ingredient(),
                    Ingredient(),
                    Ingredient(),
                    Ingredient(),
                    Ingredient(),
                    Ingredient(),
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
                Text(
                  "Preheat oven to 350.Mix together in a medium bowl the flour, baking soda, and salt.Carefully soften chocolate chips, butter, and vanilla flavoring in the microwave in 15 second increments, stirring in between, for one full minute.Beat eggs and sugar together until light an fluffy.Reduce blender speed and combine the melted chocolate chips, butter, vanilla, and slowly mix in the flour.Add in the chocolate chunks and pecans until mixed.Drop 1 tablespoon of dough onto cookie sheet, 2 - 3 inches apart and bake for 12-14 minutes, keeping your center soft and chewy. Allow to cool for 10 minutes before moving to a cooling rack to cool completely.",
                  style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: sizeH * 4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
