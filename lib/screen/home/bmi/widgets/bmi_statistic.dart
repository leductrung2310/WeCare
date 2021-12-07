import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/view_model/home_vm/bmi_view_model.dart';

class BMIStatistic extends StatelessWidget {
  const BMIStatistic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final BMIHistoryViewModel bmiHistoryViewModel =
        Provider.of<BMIHistoryViewModel>(context);

    DateTime? date = bmiHistoryViewModel.bmiRatio.updatedDate;
    String? formattedDate =
        DateFormat('dd - MM - yyyy').format(date ?? DateTime.now());
    double? ratio = bmiHistoryViewModel.bmiRatio.ratio ?? 0;

    Color calculateStatus() {
      double ratio = bmiHistoryViewModel.bmiRatio.ratio ?? 18;
      if (ratio >= 16 && ratio <= 18.5) {
        return const Color(0xFF82B6E7);
      }
      if (ratio >= 18.6 && ratio <= 25) {
        return primaryColor;
      }
      if (ratio >= 25.1 && ratio <= 40) {
        return  const Color(0xFFE06D53);
      }
      return metalGreyColor;
    }

    return Container(
      padding: EdgeInsets.fromLTRB(sizeH * 4, sizeH * 2, sizeH * 4, sizeH * 4),
      margin: EdgeInsets.fromLTRB(sizeH * 6, 0, sizeH * 6, 0),
      decoration: BoxDecoration(
        border: Border.all(color: bmiColor, width: 1),
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
              color: metalGreyColor,
              spreadRadius: 2,
              offset: const Offset(0, 3),
              blurRadius: 8)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ratio.toString(),
                style: TextStyle(
                    color: calculateStatus(),
                    fontSize: sizeV * 4,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
              Text(
                'BMI',
                style: TextStyle(
                    color: lightBlack,
                    fontSize: sizeV * 2,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BMIRatioBar(
                state: 'Underweight',
                color: const Color(0xFF82B6E7),
                sizeV: sizeV,
              ),
              BMIRatioBar(
                state: 'Normal',
                color: primaryColor,
                sizeV: sizeV,
              ),
              BMIRatioBar(
                state: 'Overweight',
                color: const Color(0xFFE06D53),
                sizeV: sizeV,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '16.0',
                style: TextStyle(
                    color: lightBlack,
                    fontSize: sizeV * 2,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(width: sizeH * 14),
              Text(
                '18.5',
                style: TextStyle(
                    color: lightBlack,
                    fontSize: sizeV * 2,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(width: sizeH * 16),
              Text(
                '25.0',
                style: TextStyle(
                    color: lightBlack,
                    fontSize: sizeV * 2,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(width: sizeH * 15),
              Text(
                '40.0',
                style: TextStyle(
                    color: lightBlack,
                    fontSize: sizeV * 2,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
          SizedBox(height: sizeV),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Last update on: ',
                style: TextStyle(
                  color: metalGreyColor,
                  fontSize: sizeV * 2.5,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                    color: lightBlack1,
                    fontSize: sizeV * 2.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BMIRatioBar extends StatelessWidget {
  final String state;
  final Color color;
  final double sizeV;

  const BMIRatioBar({
    Key? key,
    required this.state,
    required this.color,
    required this.sizeV,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          state,
          style: TextStyle(
              color: color,
              fontSize: sizeV * 1.8,
              fontWeight: FontWeight.w400,
              fontFamily: 'Poppins'),
        ),
        Container(
          height: sizeV,
          width: sizeV * 12.8,
          color: color,
        ),
      ],
    );
  }
}
