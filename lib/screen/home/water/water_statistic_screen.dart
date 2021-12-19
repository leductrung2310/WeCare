import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/home/water/widgets/detailed_statistic.dart';
import 'package:wecare_flutter/screen/home/water/widgets/water_complete_chain.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';

import 'widgets/water_weekly_chart.dart';

class WaterStatisticScreen extends StatelessWidget {
  const WaterStatisticScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    SpinKitPulse waterSpinkit = SpinKitPulse(
      color: waterColor,
      size: SizeConfig.blockSizeV! * 10,
    );

    bool _isLoading = Provider.of<WaterViewModel>(context).getIsLoadingInfo;

    Widget loadingWidget = Center(
      child: waterSpinkit,
    );

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: customAppBar(
          context,
          waterColor,
          'Statistic',
          const SizedBox.shrink(),
        ),
        body: SingleChildScrollView(
          child: _isLoading == true
              ? loadingWidget
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: sizeV * 2.5),
                    const WaterWeeklyChart(),
                    SizedBox(height: sizeV * 3),
                    const DetailedStatistic(),
                    SizedBox(height: sizeV * 3),
                    const WaterCompletedChain(),
                    SizedBox(height: sizeV * 3),
                  ],
                ),
        ),
      ),
    );
  }
}
