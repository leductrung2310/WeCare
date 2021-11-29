import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

import '../../../../constants/constants.dart';

class PersonalInformation extends StatelessWidget {
  const PersonalInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final AuthenticService authenticService =
        Provider.of<AuthenticService>(context);

    String getInfoImageAsset(bool? boy) {
      if (boy!) {
        return 'assets/images/home/bmi/boy_standing.png';
      } else if (boy == false) {
        return 'assets/images/home/bmi/girl_standing.png';
      } else {
        return 'assets/images/home/bmi/boy_standing.png';
      }
    }

    return Column(
      children: [
        SizedBox(height: sizeV),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '${authenticService.loggedInUser.height}',
                  style: TextStyle(
                      color: bmiColor,
                      fontSize: sizeH * 8,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                Text(
                  'Centimeters',
                  style: TextStyle(
                      color: lightBlack,
                      fontSize: sizeH * 4,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
                SizedBox(height: sizeV * 2),
                Text(
                  '${authenticService.loggedInUser.weight}',
                  style: TextStyle(
                      color: bmiColor,
                      fontSize: sizeH * 8,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins'),
                ),
                Text(
                  'Kilograms',
                  style: TextStyle(
                      color: lightBlack,
                      fontSize: sizeH * 4,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins'),
                ),
              ],
            ),
            Image.asset(
              getInfoImageAsset(authenticService.loggedInUser.gender!),
              height: sizeV * 30,
              width: sizeH * 45,
            ),
          ],
        ),
      ],
    );
  }
}
