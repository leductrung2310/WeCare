import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class FoodNutritionDiaLog extends StatelessWidget {
  const FoodNutritionDiaLog({
    Key? key,
    required this.title,
    required this.calories,
    required this.servingSizeG,
    required this.fatTotalG,
    required this.fatSaturatedG,
    required this.proteinG,
    required this.sodiumMg,
    required this.potassiumMg,
    required this.cholesterolMg,
    required this.carbohydratesTotalG,
    required this.fiberG,
    required this.sugarG,
  }) : super(key: key);

  final String title;
  final double calories;
  final double servingSizeG;
  final double fatTotalG;
  final double fatSaturatedG;
  final double proteinG;
  final int sodiumMg;
  final int potassiumMg;
  final int cholesterolMg;
  final double carbohydratesTotalG;
  final double fiberG;
  final double sugarG;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sizeH),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Stack(
      children: <Widget>[
        Container(
          height: 450,
          width: 360,
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeH!,
              top: SizeConfig.blockSizeH! * 9,
              right: SizeConfig.blockSizeH! * 2,
              bottom: SizeConfig.blockSizeH!),
          margin: EdgeInsets.only(top: SizeConfig.blockSizeH! * 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(SizeConfig.blockSizeH! * 2.5),
              boxShadow: const [
                BoxShadow(
                    color: Colors.grey, offset: Offset(0, 5), blurRadius: 10),
              ]),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(
                  height: sizeV / 2,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: sizeH * 9,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Title(
                              text: "Calories:",
                            ),
                            Title(
                              text: "Size:",
                            ),
                            Title(
                              text: "Fat:",
                            ),
                            Title(
                              text: "Fat saturated:",
                            ),
                            Title(
                              text: "Protein:",
                            ),
                            Title(
                              text: "Sodium:",
                            ),
                            Title(
                              text: "Potassium:",
                            ),
                            Title(
                              text: "Cholesterol:",
                            ),
                            Title(
                              text: "Carbohydrates:",
                            ),
                            Title(
                              text: "Fiber:",
                            ),
                            Title(
                              text: "Sugar:",
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: sizeH * 10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Title(
                              text: removeDecimalZeroFormat(calories) + " calo",
                            ),
                            Title(
                              text:
                                  removeDecimalZeroFormat(servingSizeG) + " g",
                            ),
                            Title(
                              text: removeDecimalZeroFormat(fatTotalG) + " g",
                            ),
                            Title(
                              text:
                                  removeDecimalZeroFormat(fatSaturatedG) + " g",
                            ),
                            Title(
                              text: removeDecimalZeroFormat(proteinG) + " g",
                            ),
                            Title(
                              text: sodiumMg.toString() + " mg",
                            ),
                            Title(
                              text: potassiumMg.toString() + " mg",
                            ),
                            Title(
                              text: cholesterolMg.toString() + " mg",
                            ),
                            Title(
                              text: carbohydratesTotalG.toString() + " g",
                            ),
                            Title(
                              text: removeDecimalZeroFormat(fiberG) + " g",
                            ),
                            Title(
                              text: removeDecimalZeroFormat(sugarG) + " g",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeV,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 8,
          top: sizeH * 12,
          child: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.clear),
          ),
        ),
        Positioned(
          left: SizeConfig.blockSizeH!,
          right: SizeConfig.blockSizeH!,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: SizeConfig.blockSizeH! * 9,
            child: ClipRRect(
                borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeH! * 10)),
                child: Image.network(
                    'https://spoonacular.com/cdn/ingredients_100x100/$title.jpg')),
          ),
        ),
      ],
    );
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return SizedBox(
      height: sizeV * 4,
      child: Text(
        text,
        style: TextStyle(
          fontSize: sizeH * 4,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),
      ),
    );
  }
}
