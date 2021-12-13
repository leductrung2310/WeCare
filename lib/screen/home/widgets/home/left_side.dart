import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/home/widgets/home/home_item.dart';
import 'package:wecare_flutter/view_model/home_vm/sleep_view_model.dart';

import '../../../../constants/constants.dart';
import '../../../../routes.dart';

class LeftSection extends StatelessWidget {
  const LeftSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final SleepViewModel sleepViewModel = Provider.of<SleepViewModel>(context);

    final hours = twoDigits(sleepViewModel.duration.inHours.remainder(24));
    final minutes = twoDigits(sleepViewModel.duration.inMinutes.remainder(60));
    final seconds = twoDigits(sleepViewModel.duration.inSeconds.remainder(60));

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        HomeItem(
          color: sleepColor,
          name: 'Sleep',
          assetIcon: 'assets/images/home/sleep/sleep.svg',
          coefficient: 30,
          child: SvgPicture.asset('assets/images/home/sleep/stars.svg'),
          left: sizeH * 2,
          top: sizeV * 6,
          right: sizeH * 2,
          bottom: sizeV * 7,
          unit: '',
          index: '$hours : $minutes : $seconds',
          onPressed: () {
            Navigator.pushNamed(context, Routes.sleepScreen);
          },
        ),
        SizedBox(height: sizeH * 5),
        HomeItem(
          color: primaryColor,
          name: 'Doctor',
          assetIcon: 'assets/images/home/walk/doctor.svg',
          index: '',
          coefficient: 15,
          child: const SizedBox.shrink(),
          left: 5,
          top: 5,
          right: 5,
          bottom: 5,
          unit: '',
          onPressed: () {
            Navigator.pushNamed(context, Routes.comingSoonScreen);
          },
        ),
      ],
    );
  }
}
