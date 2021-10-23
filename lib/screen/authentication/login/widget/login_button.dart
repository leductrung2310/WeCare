import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final loginViewModel = Provider.of<LoginViewModel>(context);
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: sizeH * 65,
        height: sizeV * 7.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sizeV * 2.5),
          gradient: const LinearGradient(colors: [
            primaryColor,
            greenLight,
            primaryColor,
          ]),
        ),
        child: Center(
          child: loginViewModel.circular
              ? const CircularProgressIndicator(color: whiteColor)
              : Text(
                  text,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: sizeV * 2.5,
                  ),
                ),
        ),
      ),
    );
  }
}
