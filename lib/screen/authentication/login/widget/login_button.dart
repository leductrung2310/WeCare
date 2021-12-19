import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.text,
    required this.onTap,
    required this.color,
    required this.textColor,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color textColor;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final loginViewModel = Provider.of<LoginViewModel>(context);
    return SizedBox(
      width: sizeH * 65,
      height: sizeV * 7.3,
      child: ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(sizeV * 2.5),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        child: Center(
          child: loginViewModel.circular
              ? const CircularProgressIndicator(color: whiteColor)
              : Text(
                  text,
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: sizeV * 2.5,
                    fontFamily: "Poppins",
                  ),
                ),
        ),
      ),
    );
  }
}
