import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wecare_flutter/constants/constants.dart';

class RegisterInputInfoTextField extends StatelessWidget {
  const RegisterInputInfoTextField({
    Key? key,
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.textInputType,
    required this.list,
  }) : super(key: key);

  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final TextInputType textInputType;
  final List<TextInputFormatter> list;

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
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: inputBorderStyle,
          filled: true,
          fillColor: grey1,
          focusedBorder: inputFocusedBorderStyle,
          prefixIcon: Icon(
            prefixIconData,
            color: primaryColor,
          ),
          suffixIcon: GestureDetector(
            onTap: () {},
            child: Icon(
              suffixIconData,
              color: primaryColor,
            ),
          ),
        ),
        keyboardType: textInputType,
        inputFormatters: list,
      ),
    );
  }
}
