import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wecare_flutter/constants/constants.dart';

class ProfileInfoTextField extends StatelessWidget {
  const ProfileInfoTextField({
    Key? key,
    this.list,
    this.suffixIconData,
    this.textController,
    this.onTap,
    this.maxlength,
    this.onChanged,
    this.onPressed,
    required this.validator,
    required this.hintText,
    required this.textInputType,
    required this.readOnly,
  }) : super(key: key);

  final List<TextInputFormatter>? list;
  final IconData? suffixIconData;
  final TextEditingController? textController;
  final VoidCallback? onTap;
  final int? maxlength;
  final VoidCallback? onChanged;
  final VoidCallback? onPressed;
  final String? Function(String? value) validator;
  final String hintText;
  final TextInputType textInputType;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) => validator(value),
        controller: textController,
        keyboardType: textInputType,
        inputFormatters: list,
        readOnly: readOnly,
        enabled: true,
        maxLength: maxlength,
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
            onTap: onTap,
            child: Icon(
              suffixIconData,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
