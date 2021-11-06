import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_circle_rest.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';

class RestScreen extends StatelessWidget {
  const RestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: sizeV * 5),
                SizedBox(
                  height: sizeV * 35,
                  child: const RestCircle(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomBTN(
                      textColor: whiteColor,
                      name: "+ 20s",
                      onPressed: () {},
                      color: primaryColor,
                      height: sizeV * 7,
                      width: sizeH * 25,
                    ),
                    CustomBTN(
                      textColor: whiteColor,
                      name: "Skip",
                      onPressed: () {},
                      color: primaryColor,
                      height: sizeV * 7,
                      width: sizeH * 25,
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeV * 3,
                ),
                SizedBox(
                  height: sizeV,
                  child: Container(
                    color: metalGreyColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Next ",
                        style: TextStyle(
                          color: metalGreyColor,
                          fontSize: sizeV * 3,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        " 2/10",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: sizeV * 3,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(
                    "Jumping Jacks ",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: sizeV * 3,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(
                    "x10",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: sizeV * 3,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/exercises/gif_exercises/jumping_jacks.gif",
                    height: sizeV * 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
