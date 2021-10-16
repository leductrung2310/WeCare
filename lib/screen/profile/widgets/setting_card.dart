import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({
    Key? key,
    required this.prefixIconData,
    required this.preText,
    required this.sufText,
    required this.color,
    required this.iconColor,
  }) : super(key: key);
  final String preText;
  final String sufText;
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
          onTap: () {},
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: sizeH * 1.3, bottom: sizeH * 1.3, left: sizeV),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizeH * 10),
                    color: color,
                  ),
                  width: sizeV * 7.5 - 17,
                  height: sizeV * 7.5 - 18,
                  child: Center(
                    child: Icon(
                      prefixIconData,
                      size: sizeH * 6.5,
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
                  preText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizeH * 4.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: sizeH * 5),
                child: Text(
                  sufText,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: sizeH * 4.25,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: sizeH * 1.3, bottom: sizeH * 1.3, right: sizeV),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizeH * 2.75),
                    color: const Color(0xFFD3D3D3),
                  ),
                  width: sizeV * 7.5 - 20,
                  height: sizeV * 7.5 - 18,
                  child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: sizeH * 5.5,
                      color: Colors.black,
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
