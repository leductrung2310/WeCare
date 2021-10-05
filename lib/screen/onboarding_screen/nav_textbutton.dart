import 'package:flutter/material.dart';

import '../../constants.dart';

class OnboardingNavTextBtn extends StatelessWidget {
  const OnboardingNavTextBtn(
      {Key? key, required this.text, required this.onPressed})
      : super(key: key);
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      splashColor: accentColor.withOpacity(0.3),
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: SizeConfig.blockSizeH! * 5,
            color: Colors.black.withOpacity(0.45),
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}