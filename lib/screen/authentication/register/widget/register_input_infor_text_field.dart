import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:wecare_flutter/constants.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: grey1,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: primaryColor, width: 3),
          ),
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
