import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/female_abs.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/arms.dart';
import 'package:wecare_flutter/view_model/workout_tab_view_model.dart';
import '../workouts_tab.dart';

class FemaleChoices extends StatelessWidget {
  const FemaleChoices({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return SizedBox(
      height: sizeV * 68,
      child: Column(
        children: [
          Container(
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
                        selectedPage: Provider.of<WorkoutTabViewModel>(context,
                                listen: false)
                            .selectedPage,
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
                        selectedPage: Provider.of<WorkoutTabViewModel>(context,
                                listen: false)
                            .selectedPage,
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
                        selectedPage: Provider.of<WorkoutTabViewModel>(context,
                                listen: false)
                            .selectedPage,
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
                        selectedPage: Provider.of<WorkoutTabViewModel>(context,
                                listen: false)
                            .selectedPage,
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
              onPageChanged: (int page) =>
                  Provider.of<WorkoutTabViewModel>(context, listen: false)
                      .selectedPage = page,
              controller:
                  Provider.of<WorkoutTabViewModel>(context, listen: false)
                      .pageController,
              children: const [
                FemaleAbs(),
                ArmsWorkout(),
                ArmsWorkout(),
                ArmsWorkout(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
