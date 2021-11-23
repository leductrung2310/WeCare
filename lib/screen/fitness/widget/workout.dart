import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class BannerWorkouts extends StatelessWidget {
  final String srcImage;
  final VoidCallback press;
  final String tag;
  const BannerWorkouts(
      {Key? key,
      required this.srcImage,
      required this.press,
      required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      height: sizeV * 17,
      child: Hero(
        tag: tag,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => press(),
              child: Image.asset(
                srcImage,
                width: sizeH * 95,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
