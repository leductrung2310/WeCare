import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';

import '../../../constants.dart';

class FoodRecommend extends StatelessWidget {
  final Color cardColor;
  final Color colorOne;
  final Color colorTwo;
  final VoidCallback onTapp;
  final String nameRecipe;
  final String descriptionRecipe;
  final String image;
  const FoodRecommend({
    Key? key,
    required this.cardColor,
    required this.colorOne,
    required this.colorTwo,
    required this.onTapp,
    required this.nameRecipe,
    required this.descriptionRecipe,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: sizeH * 56,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: sizeH * 13,
            ),
            SizedBox(
              height: sizeV,
            ),
            SizedBox(
              width: sizeH * 30,
              child: Text(
                nameRecipe,
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                  fontSize: sizeH * 5,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              descriptionRecipe,
              style: TextStyle(
                fontSize: sizeH * 3.75,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w400,
                color: const Color(0xFF7B6F72),
              ),
            ),
            SizedBox(
              height: sizeV * 1.5,
            ),
            Button(
              color1: colorOne,
              color2: colorTwo,
              onTap: onTapp,
            )
          ],
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.onTap,
    required this.color1,
    required this.color2,
  }) : super(key: key);

  final VoidCallback onTap;
  final Color color1;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            color1,
            color2,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      width: sizeH * 28,
      height: sizeV * 5,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: sizeH / 16,
        ),
        child: Ink(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [color1, color2]),
              borderRadius: BorderRadius.circular(20)),
          child: Container(
            width: 300,
            height: 100,
            alignment: Alignment.center,
            child: Text(
              'View',
              style: TextStyle(
                fontSize: sizeH * 4.5,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
