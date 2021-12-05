import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/profile/widgets/button.dart';

class ChangePasswordSuccessScreen extends StatelessWidget {
  const ChangePasswordSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: sizeV * 15,
              ),
              Image.asset(
                'assets/images/profile/changepasswordsuccess.png',
                scale: sizeV * 0.11,
                height: sizeV * 35,
              ),
              const Text(
                "Password Change",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Your password has been changed successfully",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: sizeH * 6, vertical: sizeV * 1.5),
                child: ProfileButton(
                  text: "Continue",
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.main);
                  },
                  color: primaryColor,
                  textColor: whiteColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
