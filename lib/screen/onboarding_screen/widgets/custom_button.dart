import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class CustomTextBtn extends StatelessWidget {
  const CustomTextBtn({
    Key? key,
    required this.name,
    required this.onPressed,
    required this.color,
    required this.textColor,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(60, 0, 60, 60),
      child: SizedBox(
        height: sizeH * 14,
        width: sizeV * 90,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ElevatedButton(
            onPressed: onPressed,
            child: Text(
              name,
              style: TextStyle(
                color: textColor,
                fontFamily: 'Poppins',
                fontSize: sizeH * 4.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(color),
            ),
          ),
        ),
      ),
    );
  }
}
