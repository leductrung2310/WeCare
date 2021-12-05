import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/home/widgets/home/left_side.dart';
import 'package:wecare_flutter/screen/home/widgets/home/right_side.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/home/widgets/home/walk_section.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

import '../../constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final currentUser = FirebaseAuth.instance.currentUser;

    final auth = Provider.of<AuthenticService>(context);

    String photoUrl =
        "https://firebasestorage.googleapis.com/v0/b/wecare-da049.appspot.com/o/default_avatar.png?alt=media&token=2c3cb547-e2d2-4e14-a6da-ee15b04ccb6e";
    if (auth.loggedInUser.avatarUrl != null) {
      photoUrl = auth.loggedInUser.avatarUrl!;
    } else if (currentUser!.photoURL != null) {
      photoUrl = currentUser.photoURL!;
    }

    String name = "Unknow User";
    if (auth.loggedInUser.name != null) {
      name = auth.loggedInUser.name!;
    } else if (currentUser!.displayName != null) {
      name = currentUser.displayName!;
    }

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
                  Wrap(
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
                              text: '\n$name 👋',
                              style: TextStyle(
                                fontSize: sizeV * 3.5,
                                fontFamily: 'Poppins',
                                color: lightBlack,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: sizeH * 7.5),
                  CircleAvatar(
                    backgroundImage: NetworkImage(photoUrl),
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
                  SizedBox(width: sizeH * 5),
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
