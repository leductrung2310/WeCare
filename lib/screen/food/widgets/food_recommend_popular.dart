import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class FoodRecommendPopular extends StatelessWidget {
  final VoidCallback onTapp;
  final String nameRecipe;
  final String descriptionRecipe;
  final String image;
  const FoodRecommendPopular({
    Key? key,
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

    return InkWell(
      onTap: onTapp,
      child: Padding(
        padding: EdgeInsets.only(right: sizeH * 4, bottom: sizeH * 4),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFFD3DDEF),
            borderRadius: BorderRadius.circular(sizeH * 2),
          ),
          width: sizeH * 100,
          height: sizeV * 16,
          child: Row(
            children: [
              SizedBox(
                width: sizeH * 4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: sizeH * 40,
                    child: Text(
                      nameRecipe,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: sizeH * 4.4,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: sizeH * 40,
                    child: Text(
                      descriptionRecipe,
                      style: TextStyle(
                        fontSize: sizeH * 4,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sizeH * 14),
                  bottomLeft: Radius.circular(sizeH * 14),
                  topRight: Radius.circular(sizeH * 2),
                  bottomRight: Radius.circular(sizeH * 2),
                ),
                child: Image.network(
                  image,
                  width: sizeH * 36,
                  height: sizeV * 16,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
