import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class CustomBTN extends StatelessWidget {
  const CustomBTN({
    Key? key,
    required this.name,
    required this.onPressed,
    required this.color,
    required this.textColor,
    required this.height,
    required this.width,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    return SizedBox(
      height: height,
      width: width,
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
    );
  }
}
