import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:wecare_flutter/view_model/exercise/workout_tab_view_model.dart';

class WorkoutsTab extends StatelessWidget {
  final String title;
  final String svgIcon;
  final int pageNumber;
  final Function onPressed;
  const WorkoutsTab({
    Key? key,
    required this.title,
    required this.svgIcon,
    required this.pageNumber,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        width: sizeH * 21,
        height: sizeV * 10,
        decoration: BoxDecoration(
          color: Provider.of<WorkoutTabViewModel>(context).selectedPage ==
                  pageNumber
              ? primaryColor
              : whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: primaryColor,
            width: 2.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              child: SvgIcon(
                svgIcon,
                height: sizeH * 9,
                width: sizeH * 9,
                color: Provider.of<WorkoutTabViewModel>(context).selectedPage ==
                        pageNumber
                    ? whiteColor
                    : accentColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: SizeConfig.blockSizeH! * 4,
                color: Provider.of<WorkoutTabViewModel>(context).selectedPage ==
                        pageNumber
                    ? whiteColor
                    : accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
