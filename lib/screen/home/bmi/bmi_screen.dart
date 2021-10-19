import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/home/bmi/widgets/bmi_history.dart';
import 'package:wecare_flutter/screen/home/bmi/widgets/bmi_statistic.dart';
import 'package:wecare_flutter/screen/home/bmi/widgets/bmi_information.dart';

class BMIRatioScreen extends StatefulWidget {
  const BMIRatioScreen({Key? key}) : super(key: key);

  @override
  _BMIRatioScreenState createState() => _BMIRatioScreenState();
}

class _BMIRatioScreenState extends State<BMIRatioScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: sizeV * 2),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  Text(
                    'BMI ratio',
                    style: TextStyle(
                        color: bmiColor,
                        fontSize: sizeH * 6,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins'),
                  ),
                ],
              ),
              SizedBox(height: sizeV * 2),
              const PersonalInformation(),
              SizedBox(height: sizeV * 4),
              const BMIStatistic(),
              SizedBox(height: sizeV * 3),
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
                    fontFamily: 'Poppins'),
              ),
              const BMIHistorySection(),
            ],
          ),
        ),
      ),
    );
  }
}
