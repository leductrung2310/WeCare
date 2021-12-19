import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/model/exercise/exercise_arguments.dart';
import 'package:wecare_flutter/screen/fitness/widget/custom_btn.dart';
import 'package:wecare_flutter/view_model/exercise/exercise_view_model.dart';

import '../../constants/constants.dart';
import '../../routes.dart';

class IntroWorkouts extends StatelessWidget {
  final ExerciseArguments arguments;

  const IntroWorkouts({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Hero(
                tag: arguments.tag,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: FittedBox(
                    child: Image.asset(
                      arguments.banner,
                      height: sizeV * 25.5,
                      width: sizeH * 100,
                      fit: BoxFit.cover,
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: sizeV * 50,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: arguments.listExercise.length - 1,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: sizeH * 4,
                              ),
                              Image.asset(
                                arguments.listExercise[index].gif,
                                height: sizeV * 15,
                                width: sizeV * 15,
                              ),
                              SizedBox(
                                width: sizeH * 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: sizeH * 50,
                                    child: Text(
                                      arguments.listExercise[index].name,
                                      style: oBlackTitle,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Text(
                                    arguments.listExercise[index].reps,
                                    style: oBlackTitle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 3,
                            color: grey1,
                            indent: sizeH * 6,
                            endIndent: sizeH * 5,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: sizeV * 9,
              ),
            ],
          ),
          Positioned(
            bottom: sizeV * 4,
            right: sizeH * 10,
            left: sizeH * 10,
            child: CustomBTN(
              name: "Let's Go",
              color: primaryColor,
              textColor: whiteColor,
              height: sizeV * 6,
              fontSize: 24,
              onPressed: () {
                final arg = arguments.listExercise;
                Navigator.pushNamed(
                  context,
                  Routes.workouting,
                  arguments: arg,
                );
                Provider.of<WorkoutViewModel>(context, listen: false)
                    .startTime();
              },
            ),
          ),
          Positioned(
            left: sizeH * 4,
            top: sizeV * 6,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: whiteColor,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
