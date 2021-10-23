import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/home/widgets/left_side.dart';
import 'package:wecare_flutter/screen/home/widgets/right_side.dart';
import 'package:wecare_flutter/screen/home/widgets/walk_section.dart';

import '../../constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
              SizedBox(height: sizeV * 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: sizeV * 2.8,
                        fontWeight: FontWeight.w400,
                        color: lightBlack,
                      ),
                      children: [
                        const TextSpan(text: 'How are you today,'),
                        TextSpan(
                          text: '\nJohn Wick 👋',
                          style: TextStyle(
                            fontSize: sizeV * 4.5,
                            fontFamily: 'Poppins',
                            color: lightBlack,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: sizeH * 7.5),
                  CircleAvatar(
                    backgroundImage:
                        const AssetImage('assets/images/profile/avatar.png'),
                    radius: sizeV * 2.8,
                  ),
                ],
              ),
              SizedBox(height: sizeV * 3),
              const StepCountPart(),
              SizedBox(height: sizeH * 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LeftSection(),
                  SizedBox(width: sizeH*5),
                  const RightSection(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
