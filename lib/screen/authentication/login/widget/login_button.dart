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
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 175,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
                  style: const TextStyle(
                    color: whiteColor,
                    fontSize: 20,
                  ),
                ),
        ),
      ),
    );
  }
}
