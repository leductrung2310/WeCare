import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/view_model/change_password_view_model.dart';

class ChangePasswordInputPasswordTextField extends StatelessWidget {
  const ChangePasswordInputPasswordTextField({
    Key? key,
    required this.hintText,
    required this.suffixIconData,
    required this.obscureText,
    required this.textController,
    required this.validator,
    required this.onFieldSubmitted,
    required this.focusNode,
    required this.onTap,
  }) : super(key: key);

  final String hintText;
  final IconData suffixIconData;
  final bool obscureText;
  final TextEditingController textController;
  final String? Function(String? value) validator;
  final Function(String? value) onFieldSubmitted;
  final FocusNode focusNode;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: sizeV / 2, horizontal: sizeH * 5),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onFieldSubmitted: (value) => onFieldSubmitted(value),
        focusNode: focusNode,
        validator: (value) => validator(value),
        controller: textController,
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
          suffixIcon: GestureDetector(
            onTap: () => onTap(),
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
