import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:wecare_flutter/model/statistic_data/water_statistic_data.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';

import '../../../../constants/constants.dart';

class WaterCompletedChain extends StatelessWidget {
  const WaterCompletedChain({Key? key}) : super(key: key);

  Padding _waterDrop(WaterCompleteChainData waterCompleteChain) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SvgIcon(
                'assets/images/home/water/water_drop.svg',
                color: waterCompleteChain.percentage >= 90
                    ? Colors.green
                    : (waterCompleteChain.percentage >= 60
                        ? waterColor
                        : lightBlack1),
                width: SizeConfig.blockSizeH! * 6,
                height: SizeConfig.blockSizeV! * 5,
              ),
              waterCompleteChain.percentage >= 90
                  ? Icon(
                      Icons.check,
                      color: whiteColor,
                      size: SizeConfig.blockSizeH! * 4.5,
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          Text(
            waterCompleteChain.dayOfWeek,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: SizeConfig.blockSizeV! * 2,
              color: lightBlack,
              fontWeight: FontWeight.w500,
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

    double desiredAmonut =
        Provider.of<AuthenticService>(context, listen: false).getDesiredAmount;

    List indexesList = waterViewModel.getWaterHistoryList
        .map((data) => data.waterIndex)
        .toList();
    List<WaterCompleteChainData> waterCompleteChainList = [
      WaterCompleteChainData(
          percentage: (indexesList.elementAt(0) / desiredAmonut) * 100,
          dayOfWeek: 'Mon'),
      WaterCompleteChainData(
          percentage: (indexesList.elementAt(1) / desiredAmonut) * 100,
          dayOfWeek: 'Tue'),
      WaterCompleteChainData(
          percentage: (indexesList.elementAt(2) / desiredAmonut) * 100,
          dayOfWeek: 'Wed'),
      WaterCompleteChainData(
          percentage: (indexesList.elementAt(3) / desiredAmonut) * 100,
          dayOfWeek: 'Thu'),
      WaterCompleteChainData(
          percentage: (indexesList.elementAt(4) / desiredAmonut) * 100,
          dayOfWeek: 'Fri'),
      WaterCompleteChainData(
          percentage: (indexesList.elementAt(5) / desiredAmonut) * 100,
          dayOfWeek: 'Sat'),
      WaterCompleteChainData(
          percentage: (indexesList.elementAt(6) / desiredAmonut) * 100,
          dayOfWeek: 'Sun'),
    ];

    return Container(
      width: sizeH * 90,
      height: sizeV * 17,
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: lightWaterColor,
            offset: const Offset(5.0, 5.0),
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Complete Chain',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: sizeV * 2.5,
                  fontWeight: FontWeight.w500,
                  color: lightBlack,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: sizeV * 10,
                width: sizeH * 90,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                  itemCount: waterCompleteChainList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => _waterDrop(
                    waterCompleteChainList[index],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
