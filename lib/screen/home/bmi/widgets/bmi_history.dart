import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/model/bmi_ratio_data.dart';
import 'package:wecare_flutter/view_model/bmi_view_model.dart';

class BMIHistorySection extends StatelessWidget {
  const BMIHistorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final BMIHistoryViewModel bmiHistoryViewModel =
        Provider.of<BMIHistoryViewModel>(context);
    String formattedDate = DateFormat('dd-MM-yyyy, kk:mm')
        .format(bmiHistoryViewModel.bmiRatio.updatedDate);

    Column bmiItem(BMIRatio bmiRatio, Color color) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                bmiRatio.ratio.toString(),
                style: TextStyle(
                    color: bmiColor,
                    fontSize: sizeV * 3,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins'),
              ),
              Container(
                height: sizeH * 3,
                width: sizeH * 3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                    color: metalGreyColor,
                    fontSize: sizeV * 2.2,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
          Divider(
            indent: sizeH * 4,
            endIndent: sizeH * 4,
            thickness: 1,
            color: metalGreyColor,
            height: sizeV * 1.5,
          ),
        ],
      );
    }

    return Column(
      children: [
        Divider(
          height: 2,
          thickness: 1.5,
          indent: sizeH * 10,
          endIndent: sizeH * 10,
          color: metalGreyColor,
        ),
        Text(
          'History',
          style: TextStyle(
            color: lightBlack,
            fontSize: sizeV * 4,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(sizeH * 8, sizeV, sizeH * 8, sizeV * 2),
          padding: EdgeInsets.all(sizeV),
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount:
                bmiHistoryViewModel.bmiRatioHistory.bmiRatioHistoryList.length,
            itemBuilder: (context, index) {
              var bmiHistory = bmiHistoryViewModel
                  .bmiRatioHistory.bmiRatioHistoryList[index];
              BMIStatus bmiStatus = bmiHistory.status;
              Color stateColor;
              switch (bmiStatus) {
                case BMIStatus.normal:
                  {
                    stateColor = primaryColor;
                  }
                  break;
                case BMIStatus.underweight:
                  {
                    stateColor = const Color(0xFF82B6E7);
                  }
                  break;
                case BMIStatus.overweight:
                  {
                    stateColor = const Color(0xFFE06D53);
                  }
                  break;
              }
              return bmiItem(bmiHistory, stateColor);
            },
          ),
        ),
      ],
    );
  }
}
