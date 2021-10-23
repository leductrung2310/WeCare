import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class CardImageFood extends StatelessWidget {
  const CardImageFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Padding(
      padding: EdgeInsets.only(
        top: sizeV,
        bottom: sizeV * 1.5,
      ),
      child: Container(
        height: sizeV * 25,
        width: sizeH * 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeH * 4),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: sizeH * 9.5,
            ),
            CircleAvatar(
              radius: sizeV * 8.5,
            ),
            SizedBox(
              width: sizeH * 6,
            ),
            Column(
              children: [
                SizedBox(
                  height: sizeV * 6.5,
                ),
                Text(
                  "120g",
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
                  "15g",
                  style: styleOne,
                ),
                Text(
                  "Fat",
                  style: styleTwo,
                ),
              ],
            ),
            SizedBox(
              width: sizeH * 7.5,
            ),
            Column(
              children: [
                SizedBox(
                  height: sizeV * 6.5,
                ),
                Text(
                  "120g",
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
                  "15g",
                  style: styleOne,
                ),
                Text(
                  "Calories",
                  style: styleTwo,
                ),
              ],
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
