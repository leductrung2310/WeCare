import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/home/bmi/widgets/bmi_history.dart';
import 'package:wecare_flutter/screen/home/bmi/widgets/bmi_statistic.dart';
import 'package:wecare_flutter/screen/home/bmi/widgets/bmi_information.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/view_model/bmi_view_model.dart';

class BMIRatioScreen extends StatelessWidget {
  const BMIRatioScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: customAppBar(
          context,
          bmiColor,
          'BMI Ratio',
          const Text(''),
        ),
        body: ChangeNotifierProvider(
          create: (context) => BMIHistoryViewModel(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const PersonalInformation(),
                SizedBox(height: sizeV * 4),
                const BMIStatistic(),
                SizedBox(height: sizeV * 3),
                const BMIHistorySection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
