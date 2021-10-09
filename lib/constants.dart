import 'package:flutter/material.dart';

const primaryColor = Color(0xFF91c788);
const accentColor = Color.fromRGBO(0, 0, 0, .7);
const whiteColor = Colors.white;
const grey1 = Color(0xFFf3f3f3);
const greenLight = Color(0xFF91c777);
Color metalGreyColor = Colors.grey.withOpacity(0.5);

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

//Login - Register

final inputBorderStyle = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(SizeConfig.blockSizeH! * 3.65)),
  borderSide: BorderSide.none,
);

final inputFocusedBorderStyle = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(SizeConfig.blockSizeH! * 3.65)),
  borderSide:
      BorderSide(color: primaryColor, width: SizeConfig.blockSizeH! - 1),
);

final inputFocusedErrorBorderStyle = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(SizeConfig.blockSizeH! * 3.65)),
  borderSide:
      BorderSide(color: Colors.red[400]!, width: SizeConfig.blockSizeH! - 1),
);

final inputErrorBorderStyle = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(SizeConfig.blockSizeH! * 3.65)),
  borderSide: BorderSide.none,
);

final authTextStyle = TextStyle(
  color: accentColor,
  fontSize: SizeConfig.blockSizeH! * 4.3,
);

final authTextStyle1 = TextStyle(
  color: primaryColor,
  fontSize: SizeConfig.blockSizeH! * 4.3,
  fontWeight: FontWeight.bold,
);
