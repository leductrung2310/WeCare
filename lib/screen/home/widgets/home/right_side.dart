import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/home/widgets/home/home_item.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/circle_progress.dart';
import 'package:wecare_flutter/view_model/home_vm/bmi_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';

import '../../../../constants/constants.dart';

class RightSection extends StatelessWidget {
  const RightSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final BMIHistoryViewModel bmiHistoryViewModel =
        Provider.of<BMIHistoryViewModel>(context);
    double? ratio = bmiHistoryViewModel.bmiRatio.ratio;
    final WaterViewModel waterViewModel = Provider.of<WaterViewModel>(context);

    String waterIndex = (waterViewModel.getCurrentIndex).toStringAsFixed(
        (waterViewModel.getCurrentIndex).truncateToDouble() ==
                waterViewModel.getCurrentIndex
            ? 1
            : 2);
    String bmiRatio = (ratio ?? 0).toStringAsFixed(
        (ratio ?? 0).truncateToDouble() == waterViewModel.getCurrentIndex
            ? 1
            : 2);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        HomeItem(
          color: waterColor,
          name: 'Water',
          assetIcon: 'assets/images/home/water/water_drop.svg',
          index: waterIndex,
          coefficient: 22.5,
          child: const CustomProgressIndicator(),
          left: sizeV * 5,
          top: sizeV * 5.5,
          right: sizeV * 5,
          bottom: sizeV * 5.5,
          unit: 'L',
          onPressed: () {
            Navigator.pushNamed(context, Routes.waterScreen);
          },
        ),
        SizedBox(height: sizeH * 5),
        HomeItem(
          color: bmiColor,
          name: 'BMI Ratio',
          assetIcon: 'assets/images/home/bmi/bmi_weight.svg',
          index: bmiRatio,
          coefficient: 22.5,
          child: SvgPicture.asset('assets/images/home/bmi/bmi_vector.svg'),
          left: sizeH * 4,
          top: sizeV * 6,
          right: sizeH * 4,
          bottom: sizeV * 6,
          unit: '',
          onPressed: () async {
            Navigator.pushNamed(context, Routes.bmiScreen);
          },
        ),
      ],
    );
  }
}
