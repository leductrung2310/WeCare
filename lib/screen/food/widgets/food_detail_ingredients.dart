import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class Ingredient extends StatelessWidget {
  final String image;
  final String name;
  final String unit;
  const Ingredient({
    Key? key,
    required this.image,
    required this.name,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9.5),
      child: SizedBox(
        // height: sizeH * 22,
        width: sizeH * 37,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: sizeV * 11,
              width: sizeV * 11,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(sizeH * 4),
                  bottomLeft: Radius.circular(sizeH * 4),
                  topRight: Radius.circular(sizeH * 4),
                  bottomRight: Radius.circular(sizeH * 4),
                ),
                child: Image.network(
                    'https://spoonacular.com/cdn/ingredients_100x100/$image'),
              ),
            ),
            Text(
              name,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: sizeH * 4,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              unit,
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: sizeH * 3.5,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
