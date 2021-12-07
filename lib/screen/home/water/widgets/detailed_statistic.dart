import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/statistic_data/water_statistic_data.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';

import '../../../../constants/constants.dart';

class DetailedStatistic extends StatelessWidget {
  const DetailedStatistic({Key? key}) : super(key: key);

  Container _boxStatistic(WaterDetailedStatisticData data) {
    return Container(
      width: SizeConfig.blockSizeH! * 29,
      height: SizeConfig.blockSizeV! * 18,
      decoration: BoxDecoration(
        color: waterColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            data.index.toStringAsFixed(0),
            style: TextStyle(
              color: whiteColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: SizeConfig.blockSizeV! * 3.8,
            ),
          ),
          Text(
            data.unit,
            style: TextStyle(
              color: lightBlack,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: SizeConfig.blockSizeV! * 2,
            ),
          ),
          Text(
            data.title,
            style: TextStyle(
              color: whiteColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.blockSizeV! * 2.2,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    WaterViewModel waterViewModel = Provider.of<WaterViewModel>(context);

    List<WaterDetailedStatisticData> waterDetailedListData = [
      WaterDetailedStatisticData(index: waterViewModel.getAverageIndex, unit: 'ml/day', title: 'Average'),
      WaterDetailedStatisticData(index: waterViewModel.getAveragePercent, unit: '%', title: 'Completed'),
      WaterDetailedStatisticData(index: waterViewModel.getAverageDrinkTimes, unit: 'times/day', title: 'Times'),
    ];

    return SizedBox(
      height: sizeV * 16,
      width: sizeH * 100,
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: waterDetailedListData.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: _boxStatistic(waterDetailedListData[index]),
            );
          }),
    );
  }
}
