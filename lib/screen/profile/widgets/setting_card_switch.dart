import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class SettingSwitchCard extends StatelessWidget {
  const SettingSwitchCard({
    Key? key,
    required this.prefixIconData,
    required this.preText,
    required this.sufText,
    required this.color,
    required this.iconColor,
    required this.onChanged,
    required this.value,
  }) : super(key: key);
  final String preText;
  final String sufText;
  final IconData prefixIconData;
  final Color color;
  final Color iconColor;
  final Function(bool value) onChanged;
  final bool value;

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
          onPressed: () {},
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(sizeH * 3),
              ),
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(horizontal: sizeH * 2)),
            backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
            elevation: MaterialStateProperty.all<double>(0.15),
            //overlayColor: MaterialStateProperty.all<Color>(primaryColor),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: sizeH * 1.3, bottom: sizeH * 1.3),
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
                  style: profileText,
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
                padding: EdgeInsets.only(top: sizeH * 1.3, bottom: sizeH * 1.3),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(sizeH * 2.75),
                  ),
                  width: sizeV * 7.5 - 20,
                  height: sizeV * 7.5 - 18,
                  child: Center(
                    child: Switch(
                        value: value, onChanged: (value) => onChanged(value)),
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
