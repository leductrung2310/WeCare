import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

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
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: sizeH * 2.8, horizontal: sizeH * 5),
      child: Container(
        width: sizeV * 56.22,
        height: sizeV * 6.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(sizeH * 3)),
          color: Colors.white,
        ),
        child: InkWell(
          onTap: () => onTap(),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: sizeH * 1.3, bottom: sizeH * 1.3, left: sizeV),
                child: Container(
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
                padding: EdgeInsets.only(right: sizeV),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: sizeH * 5.5,
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
