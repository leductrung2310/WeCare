import 'package:flutter/material.dart';

import '../../../../constants.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '170',
                  style: TextStyle(
                      color: bmiColor,
                      fontSize: sizeH * 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                Text(
                  'Centimeters',
                  style: TextStyle(
                      color: lightBlack,
                      fontSize: sizeH * 4.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(height: sizeV * 2),
                Text(
                  '65',
                  style: TextStyle(
                      color: bmiColor,
                      fontSize: sizeH * 10,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                Text(
                  'Kilograms',
                  style: TextStyle(
                      color: lightBlack,
                      fontSize: sizeH * 4.5,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),
            Image.asset(
              'assets/images/bmi/boy_standing.png',
              height: sizeH * 70,
              width: sizeV * 25,
            ),
          ],
        ),
      ],
    );
  }
}
