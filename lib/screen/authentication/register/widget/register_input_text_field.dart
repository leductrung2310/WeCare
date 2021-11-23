import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class RegisterInputTextField extends StatelessWidget {
  const RegisterInputTextField({
    Key? key,
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.obscureText,
    required this.onChanged,
    required this.textController,
    required this.validator,
    required this.onFieldSubmitted,
    required this.focusNode,
  }) : super(key: key);

  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function(String value) onChanged;
  final TextEditingController textController;
  final String? Function(String? value) validator;
  final Function(String? value) onFieldSubmitted;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: sizeV * 1.22,
        horizontal: sizeH * 5,
      ),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: (value) => onFieldSubmitted(value),
        focusNode: focusNode,
        validator: (value) => validator(value),
        controller: textController,
        onChanged: (value) => onChanged(value),
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
              if (suffixIconData == Icons.clear) {
                textController.clear();
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
