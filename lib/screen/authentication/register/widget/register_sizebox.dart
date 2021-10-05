import 'package:flutter/material.dart';

class RegisterSizebox extends StatelessWidget {
  const RegisterSizebox({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 15,
        ),
        Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
