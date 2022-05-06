import 'package:flutter/material.dart';
import 'package:svg_icon/svg_icon.dart';

import '../../../../constants/constants.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    Key? key,
    required this.color,
    required this.name,
    required this.assetIcon,
    required this.index,
    required this.coefficient,
    required this.child,
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    required this.unit,
    required this.onPressed,
  }) : super(key: key);
  final String name;
  final Color color;
  final String assetIcon;
  final String index;
  final double coefficient;
  final String unit;
  final Widget child;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return InkWell(
      onTap: onPressed,
      splashColor: grey1,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: sizeH * 42.5,
        height: sizeV * coefficient,
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            Positioned(
              top: sizeV * 2,
              left: sizeH * 4,
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: sizeV * 2.3,
                  color: lightBlack1,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Positioned(
              top: sizeV * 2,
              right: sizeH * 4,
              child: SvgIcon(
                assetIcon,
                color: color,
              ),
            ),
            Positioned(
              left: left,
              top: top,
              right: right,
              bottom: bottom,
              child: child,
            ),
            Positioned(
              bottom: sizeV * 2,
              left: sizeH * 4,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizeV * 3,
                    fontWeight: FontWeight.w600,
                    color: lightBlack,
                  ),
                  children: [
                    TextSpan(text: index),
                    TextSpan(
                      text: unit,
                      style: TextStyle(
                        fontSize: sizeV * 2,
                        fontFamily: 'Poppins',
                        color: lightBlack1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
