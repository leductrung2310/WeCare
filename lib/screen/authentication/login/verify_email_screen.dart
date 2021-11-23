import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: sizeV * 8),
              Image.asset(
                'assets/images/authentication/mail_check.png',
              ),
              SizedBox(height: sizeV * 4),
              Text(
                'Verify Your Email',
                style: oTitle,
              ),
              Text(
                'We have sent an email to\nyour email address',
                style: oSubtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizeV * 6),
              CustomTextBtn(
                name: 'Go to Login',
                onPressed: () {},
                color: primaryColor,
                textColor: whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
