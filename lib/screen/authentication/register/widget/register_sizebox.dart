import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class RegisterSizebox extends StatelessWidget {
  const RegisterSizebox({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Column(
      children: <Widget>[
        SizedBox(
          height: sizeH * 3.65,
        ),
        Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: sizeH * 6.1,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
