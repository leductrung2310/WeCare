import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';

class LoginInputPasswordTextField extends StatelessWidget {
  const LoginInputPasswordTextField({
    Key? key,
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.obscureText,
    required this.onChanged,
    required this.validator,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.inputType,
    required this.controller,
  }) : super(key: key);

  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function(String value) onChanged;
  final String? Function(String? value) validator;
  final Function(String? value) onFieldSubmitted;
  final FocusNode focusNode;
  final TextInputType inputType;
  final TextEditingController controller;

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
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: (value) => onFieldSubmitted(value),
        focusNode: focusNode,
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
            color: primaryColor,
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
