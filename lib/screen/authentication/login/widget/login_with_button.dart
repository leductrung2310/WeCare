import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class LoginWithButton extends StatelessWidget {
  const LoginWithButton({
    Key? key,
    required this.onPress,
    required this.icon,
    required this.size,
  }) : super(key: key);

  final IconData icon;
  final double size;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => onPress(),
      icon: Icon(icon),
      iconSize: size,
      color: primaryColor,
    );
  }
}
