import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/fitness/widget/female/female_abs.dart';
import 'package:wecare_flutter/screen/fitness/widget/male/arms.dart';
import 'package:wecare_flutter/view_model/workout_tab_view_model.dart';
import '../workouts_tab.dart';
import '../workouts_tab.dart';

class WorkoutChoice extends StatelessWidget {
  const WorkoutChoice({Key? key}) : super(key: key);

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
                            title: "Arms",
                            svgIcon: "assets/icons/arms.svg",
                            pageNumber: 0,
                            onPressed: () {
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .selectedPage = 0;
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .pageController = 0;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: WorkoutsTab(
                            title: "ABS",
                            svgIcon: "assets/icons/abs.svg",
                            pageNumber: 1,
                            onPressed: () {
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .selectedPage = 1;
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .pageController = 1;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: WorkoutsTab(
                            title: "Shoulder",
                            svgIcon: "assets/icons/shoulder.svg",
                            pageNumber: 2,
                            onPressed: () {
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .selectedPage = 2;
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .pageController = 2;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: WorkoutsTab(
                            title: "Chest",
                            svgIcon: "assets/icons/chest.svg",
                            pageNumber: 3,
                            onPressed: () {
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .selectedPage = 3;
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .pageController = 3;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                        child: WorkoutsTab(
                            title: "Legs",
                            svgIcon: "assets/icons/legs.svg",
                            pageNumber: 4,
                            onPressed: () {
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .selectedPage = 4;
                              Provider.of<WorkoutTabViewModel>(context,
                                      listen: false)
                                  .pageController = 4;
                            }),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  );
                }),
          ),
          Expanded(
            child: PageView(
              onPageChanged: (int page) {
                if (Provider.of<WorkoutTabViewModel>(context, listen: false)
                        .selectedPage ==
                    page) {
                  Provider.of<WorkoutTabViewModel>(context, listen: false)
                          .selectedPage =
                      Provider.of<WorkoutTabViewModel>(context, listen: false)
                          .pageController;
                }
              },
              controller:
                  Provider.of<WorkoutTabViewModel>(context, listen: false)
                      .pageController,
              children: const [
                ArmsWorkout(),
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
