import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      appBar: customAppBar(context, primaryColor, "", const SizedBox.shrink()),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/images/coming_soon.svg',
            width: sizeH * 90,
            height: sizeV * 60,
          ),
          Text(
            'We are under construction',
            style: oBlackTitle,
          )
        ],
      ),
    );
  }
}
