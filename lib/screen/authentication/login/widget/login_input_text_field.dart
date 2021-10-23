import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';

class LoginInputTextField extends StatelessWidget {
  const LoginInputTextField({
    Key? key,
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.obscureText,
    required this.onChanged,
    required this.validator,
    required this.onFieldSubmitted,
    required this.inputType,
  }) : super(key: key);

  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function(String value) onChanged;
  final String? Function(String? value) validator;
  final Function(String? value) onFieldSubmitted;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: sizeV * 1.22,
        horizontal: sizeH * 5,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: (value) => onFieldSubmitted(value),
        keyboardType: inputType,
        onChanged: (value) => onChanged(value),
        validator: (value) => validator(value),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: accentColor),
          hintText: hintText,
          enabledBorder: inputBorderStyle,
          filled: true,
          fillColor: grey1,
          focusedBorder: inputFocusedBorderStyle,
          focusedErrorBorder: inputFocusedBorderStyle,
          errorBorder: inputErrorBorderStyle,
          prefixIcon: Icon(
            prefixIconData,
            color: primaryColor
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              if (hintText == "Password") {
                loginViewModel.isVisible = !loginViewModel.isVisible;
              } else {}
            },
            child: Icon(
              suffixIconData,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
