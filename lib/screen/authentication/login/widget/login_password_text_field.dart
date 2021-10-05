import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class LoginPasswordTextField extends StatefulWidget {
  const LoginPasswordTextField({Key? key}) : super(key: key);

  @override
  _LoginPasswordTextFieldState createState() => _LoginPasswordTextFieldState();
}

class _LoginPasswordTextFieldState extends State<LoginPasswordTextField> {
  bool isPassword = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Hint Text',
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          filled: true,
          fillColor: grey1,
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: primaryColor, width: 3),
          ),
          prefixIcon: const Icon(
            Icons.lock,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                isPassword = !isPassword;
              });
            },
            icon: Icon(
              isPassword ? Icons.visibility_off : Icons.visibility,
              color: primaryColor,
            ),
          ),
        ),
        obscureText: isPassword,
      ),
    );
  }
}
