import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

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
              SizedBox(height: sizeV * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ],
              ),
              SizedBox(height: sizeV * 6),
              Image.asset(
                'assets/images/authentication/forget_password.png',
              ),
              SizedBox(height: sizeV * 4),
              Text(
                'Forget Your Password?',
                style: oTitle,
              ),
              Text(
                'Enter your email address to\nreset your password',
                style: oSubtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: sizeV * 6),
              CustomTextBtn(
                name: 'Reset Password',
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
