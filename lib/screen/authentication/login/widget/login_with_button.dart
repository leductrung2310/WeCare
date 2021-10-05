import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class LoginWithButton extends StatelessWidget {
  const LoginWithButton({
    Key? key,
    required this.icon,
    required this.size,
  }) : super(key: key);

  final IconData icon;
  final double size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: Icon(icon),
      iconSize: size,
      color: primaryColor,
    );
  }
}
