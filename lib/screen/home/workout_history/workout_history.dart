import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';

class WorkoutHistory extends StatelessWidget {
  const WorkoutHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return SafeArea(  
      child: Scaffold(
        appBar: customAppBar(
            context, primaryColor, 'Workout', const SizedBox.shrink()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: sizeV * 2),
              
            ],
          ),
        ),
      ),
    );
  }
}
