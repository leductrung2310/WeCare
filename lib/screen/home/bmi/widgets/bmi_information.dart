import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/view_model/bmi_view_model.dart';

import '../../../../constants/constants.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final BMIHistoryViewModel bmiHistoryViewModel =
        Provider.of<BMIHistoryViewModel>(context);

    return Column(
      children: [
        SizedBox(height: sizeV * 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '${bmiHistoryViewModel.newHeight}',
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
                  '${bmiHistoryViewModel.newWeight}',
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
              'assets/images/home/bmi/boy_standing.png',
              height: sizeH * 70,
              width: sizeV * 25,
            ),
          ],
        ),
      ],
    );
  }
}
