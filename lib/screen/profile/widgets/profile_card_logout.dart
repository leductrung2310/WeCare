import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class ProfileCardLogout extends StatelessWidget {
  const ProfileCardLogout({
    Key? key,
    required this.prefixIconData,
    required this.text,
    required this.color,
    required this.iconColor,
  }) : super(key: key);
  final String text;
  final IconData prefixIconData;
  final Color color;
  final Color iconColor;

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
          onTap: () {
            print("object");
          },
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
              Container(
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: sizeH * 4.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
