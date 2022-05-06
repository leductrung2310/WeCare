import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class CustomBTN extends StatelessWidget {
  const CustomBTN({
    Key? key,
    required this.name,
    required this.onPressed,
    this.color,
    this.textColor,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.radius,
    this.widthBorder,
    this.colorBorder,
  }) : super(key: key);
  final String name;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? radius;
  final double? widthBorder;
  final Color? colorBorder;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    return SizedBox(
      height: height,
      width: width,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              width: widthBorder ?? 1, color: colorBorder ?? whiteColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            name,
            style: TextStyle(
              color: textColor ?? accentColor,
              fontFamily: 'Poppins',
              fontSize: fontSize ?? sizeH * 4.5,
              fontWeight: fontWeight ?? FontWeight.w500,
            ),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 10),
              ),
            ),
            backgroundColor:
                MaterialStateProperty.all<Color>(color ?? whiteColor),
          ),
        ),
      ),
    );
  }
}
