import 'package:flutter/material.dart';

import '../../constants.dart';

class OnboardingNavBtn extends StatelessWidget {
  const OnboardingNavBtn({Key? key, required this.onPressed}) : super(key: key);
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: accentColor.withOpacity(0.8),
      borderRadius: BorderRadius.circular(5),
      child: Container(
        height: SizeConfig.blockSizeV! * 6,
        width: SizeConfig.blockSizeV! * 6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
        ),
        child: const Center(
          child: Icon(
            Icons.navigate_next,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}