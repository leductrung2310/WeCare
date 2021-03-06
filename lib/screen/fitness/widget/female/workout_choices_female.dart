import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/female_abs.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/female_arm.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/female_butt.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/female_thigh.dart';
import 'package:wecare_flutter/view_model/exercise/workout_tab_view_model.dart';
import '../workouts_tab.dart';

class FemaleChoices extends StatelessWidget {
  const FemaleChoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    return SizedBox(
      height: sizeV * 68,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              itemCount: 1,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: WorkoutsTab(
                        title: "ABS",
                        svgIcon: "assets/icons/abs_female.svg",
                        pageNumber: 0,
                        onPressed: () {
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .selectedPage = 0;
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .pageController = 0;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: WorkoutsTab(
                        title: "Thigh",
                        svgIcon: "assets/icons/thigh_female.svg",
                        pageNumber: 1,
                        onPressed: () {
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .selectedPage = 1;
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .pageController = 1;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: WorkoutsTab(
                        title: "Butt",
                        svgIcon: "assets/icons/butt_female.svg",
                        pageNumber: 2,
                        onPressed: () {
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .selectedPage = 2;
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .pageController = 2;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: WorkoutsTab(
                        title: "Arm",
                        svgIcon: "assets/icons/arm_female.svg",
                        pageNumber: 3,
                        onPressed: () {
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .selectedPage = 3;
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .pageController = 3;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller:
                  Provider.of<WorkoutTabViewModel>(context, listen: false)
                      .pageController,
              children: const [
                FemaleAbs(),
                FemaleThigh(),
                FemaleButt(),
                FemaleArm(),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
