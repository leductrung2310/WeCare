import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/model/bmi_history_data.dart';

class BMIHistorySection extends StatelessWidget {
  const BMIHistorySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    Column bmiItem(BMIHistory bmiHistory, Color color) {
      String formattedDate =
          DateFormat('dd-MM-yyyy, kk:mm').format(bmiHistory.date);
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                bmiHistory.ratio.toString(),
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
                formattedDate.toString(),
                style: TextStyle(
                    color: metalGreyColor,
                    fontSize: sizeV * 2,
                    fontWeight: FontWeight.w400,
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

    return Container(
      margin: EdgeInsets.fromLTRB(sizeH * 8, sizeV, sizeH * 8, sizeV * 2),
      padding: EdgeInsets.all(sizeV),
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: bmiData.length,
        itemBuilder: (context, index) {
          BMIHistory bmiHistory = bmiData[index];
          BMIState bmiState = bmiHistory.state;
          Color stateColor;
          switch (bmiState) {
            case BMIState.normal:
              {
                stateColor = primaryColor;
              }
              break;
            case BMIState.underweight:
              {
                stateColor = const Color(0xFF82B6E7);
              }
              break;
            case BMIState.overweight:
              {
                stateColor = const Color(0xFFE06D53);
              }
              break;
          }
          return bmiItem(bmiHistory, stateColor);
        },
      ),
    );
  }
}
