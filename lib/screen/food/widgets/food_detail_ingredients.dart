import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class Ingredient extends StatelessWidget {
  const Ingredient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9.5),
      child: Container(
        // height: sizeH * 22,
        // width: sizeV * 12,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20), color: primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: sizeV * 11,
              width: sizeV * 11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFFD3DDEF),
              ),
            ),
            SizedBox(
              height: sizeV / 2,
            ),
            Text(
              "data",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: sizeH * 4,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "data",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: sizeH * 3,
                  fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
