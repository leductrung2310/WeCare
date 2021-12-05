import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class AmountSelection extends StatelessWidget {
  const AmountSelection({Key? key}) : super(key: key);

  IconButton leftArrow() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.arrow_back_ios,
        color: metalGreyColor,
        size: 30,
      ),
    );
  }

  IconButton rightArrow() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.arrow_forward_ios,
        color: metalGreyColor,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          child: leftArrow(),
        ),
        
        SizedBox(
          child: rightArrow(),
        ),
      ],
    );
  }
}
