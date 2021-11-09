import 'package:flutter/material.dart';
import 'package:wecare_flutter/model/water_statistic_data.dart';

import '../../../../constants.dart';

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
            data.index.toString(),
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

    return SizedBox(
      height: sizeV * 16,
      width: sizeH * 100,
      child: ListView.builder(
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
