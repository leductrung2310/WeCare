import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/view_model/workout_tab_view_model.dart';

import '../../constants.dart';

class Workouting extends StatelessWidget {
  const Workouting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/exercises/gif_exercises/jumping_jacks.gif",
                height: sizeV * 60,
                width: sizeH * 100,
              ),
              Text(
                "Jumping Jack",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.blockSizeH! * 8,
                  color: Colors.black.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "X 30",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: SizeConfig.blockSizeH! * 8,
                  color: Colors.black.withOpacity(0.85),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: sizeV * 3,
              ),
              Container(
                height: sizeV * 13,
                width: sizeH * 70,
                decoration: BoxDecoration(
                  color: grey1,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: metalGreyColor,
                  ),
                ),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 60,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.takerest);
                        },
                        icon: const Icon(
                          Icons.skip_previous,
                          color: primaryColor,
                        ),
                      ),
                      IconButton(
                        iconSize: 60,
                        onPressed: () {},
                        icon: const Icon(
                          Icons.pause_circle,
                          color: primaryColor,
                        ),
                      ),
                      IconButton(
                        iconSize: 60,
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.finishworout);
                          Provider.of<WorkoutTabViewModel>(context,
                                  listen: false)
                              .confettiController
                              .play();
                        },
                        icon: const Icon(
                          Icons.skip_next,
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: sizeH * 4,
            top: sizeV * 6,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
