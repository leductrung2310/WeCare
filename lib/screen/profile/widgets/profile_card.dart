import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.prefixIconData,
    required this.text,
    required this.color,
    required this.iconColor,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final IconData prefixIconData;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: sizeH * 2.8, horizontal: sizeH * 5),
      child: SizedBox(
        width: sizeV * 56.22,
        height: sizeV * 6.4,
        child: ElevatedButton(
          onPressed: onTap,
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizeH * 3),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: sizeH * 2)),
            backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
            elevation: MaterialStateProperty.all<double>(0.25),
            overlayColor: MaterialStateProperty.all<Color>(greenLightProfile),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(sizeH * 2.5),
                  color: color,
                ),
                width: sizeV * 7.5 - 20,
                height: sizeV * 7.5 - 18,
                child: Center(
                  child: Icon(
                    prefixIconData,
                    size: sizeH * 6,
                    color: iconColor,
                  ),
                ),
              ),
              SizedBox(
                width: sizeH * 4,
              ),
              Center(
                child: Text(
                  text,
                  style: profileText,
                ),
              ),
              const Spacer(),
              Container(
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: sizeH * 5.5,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
