import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

AppBar customAppBar(
    BuildContext context, Color color, String name, Widget child) {
  return AppBar(
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: color,
        size: SizeConfig.blockSizeV! * 3.5,
      ),
    ),
    toolbarHeight: SizeConfig.blockSizeV! * 7.5,
    title: Text(
      name,
      style: TextStyle(
        color: color,
        fontSize: SizeConfig.blockSizeH! * 7,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      ),
    ),
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    backgroundColor: Colors.transparent,
    elevation: 0,
    actions: [child],
  );
}
