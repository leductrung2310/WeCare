import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wecare_flutter/constants/constants.dart';

class ProfileInfoTextField extends StatelessWidget {
  const ProfileInfoTextField({
    Key? key,
    required this.hintText,
    required this.suffixIconData,
    //required this.textController,
    //required this.validator,
    //required this.onFieldSubmitted,
    //required this.focusNode,
    required this.onTap,
    required this.textInputType,
    this.list,
  }) : super(key: key);

  final String hintText;
  final IconData suffixIconData;
  final TextInputType textInputType;
  final List<TextInputFormatter>? list;
  //final TextEditingController textController;
  //final String? Function(String? value) validator;
  //final Function(String? value) onFieldSubmitted;
  //final FocusNode focusNode;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      //onFieldSubmitted: (value) => onFieldSubmitted(value),
      //focusNode: focusNode,
      //validator: (value) => validator(value),
      //controller: textController,
      keyboardType: textInputType,
      inputFormatters: list,
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: accentColor),
        hintText: hintText,
        enabledBorder: inputBorderStyleProfile,
        filled: true,
        fillColor: grey1,
        focusedBorder: inputFocusedBorderStyleProfile,
        focusedErrorBorder: inputFocusedBorderStyleProfile,
        errorBorder: inputErrorBorderStyleProfile,
        suffixIcon: GestureDetector(
          onTap: () => onTap(),
          child: Icon(
            suffixIconData,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
