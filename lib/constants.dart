import 'package:flutter/material.dart';

const primaryColor = Color(0xFF91c788);
const accentColor = Color.fromRGBO(0, 0, 0, .7);
const whiteColor = Colors.white;
const grey1 = Color(0xFFf3f3f3);
const greenLight = Color(0xFF91c777);
const bmiColor = Color(0xFFF6AE64);
const waterColor = Color(0xFF4499E7);
Color lightWaterColor = const Color(0xFF4499E7).withOpacity(0.2);
Color metalGreyColor = Colors.grey.withOpacity(0.5);
Color lightBlack = Colors.black.withOpacity(0.65);

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? blockSizeH;
  static double? blockSizeV;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    blockSizeH = screenWidth! / 100;
    blockSizeV = screenHeight! / 100;
  }
}

//Todo: Initialize text style for onboarding screen
final oTitle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: Colors.black.withOpacity(0.85),
  fontWeight: FontWeight.w600,
);

final oSubtitle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 4,
  color: Colors.black.withOpacity(0.45),
  fontWeight: FontWeight.w400,
);

// TextStyle white
final oWhiteTitle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 7,
  color: whiteColor,
  fontWeight: FontWeight.w600,
);

final oWhiteText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 4,
  color: whiteColor,
  fontWeight: FontWeight.w500,
);

final oBlackTitle = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 5.5,
  color: accentColor,
  fontWeight: FontWeight.w600,
  decoration: TextDecoration.none,
);

final oPrimaryText = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 4,
  color: primaryColor,
  fontWeight: FontWeight.w400,
);

final oBlackSub = TextStyle(
  fontFamily: 'Poppins',
  fontSize: SizeConfig.blockSizeH! * 3,
  color: accentColor,
  fontWeight: FontWeight.w600,
);
