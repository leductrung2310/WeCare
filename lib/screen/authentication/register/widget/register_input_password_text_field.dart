import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class RegisterInputPasswordTextField extends StatelessWidget {
  const RegisterInputPasswordTextField({
    Key? key,
    required this.hintText,
    required this.prefixIconData,
    required this.suffixIconData,
    required this.obscureText,
    required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final bool obscureText;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextFormField(
        autofocus: true,
        onChanged: (value) => onChanged(value),
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle: const TextStyle(color: accentColor),
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
            onTap: () {
              if (hintText == "Password") {
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
