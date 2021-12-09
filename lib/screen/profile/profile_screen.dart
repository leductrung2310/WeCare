import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_card.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_card_logout.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/services/google_service.dart';
import 'package:wecare_flutter/view_model/change_password_view_model.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/bmi_view_model.dart';
import 'package:wecare_flutter/view_model/notification_view_nodel.dart';
import 'package:wecare_flutter/view_model/home_vm/water_view_model.dart';
import 'package:wecare_flutter/view_model/proflie_view_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final authService = Provider.of<AuthenticService>(context, listen: false);
    final currentUser = FirebaseAuth.instance.currentUser;
    Provider.of<ProfileViewModel>(context, listen: false).buildContext =
        context;

    late String name;
    name = authService.loggedInUser.name ??
        (currentUser?.displayName ?? 'Unknow User');

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFC),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sizeH * 9,
              ),
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: sizeV * 9.75,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        radius: sizeV * 100 / 5,
                        backgroundImage: NetworkImage(Provider.of<
                                    AuthenticService>(context)
                                .loggedInUser
                                .avatarUrl ??
                            'https://firebasestorage.googleapis.com/v0/b/wecare-da049.appspot.com/o/default_avatar.png?alt=media&token=2c3cb547-e2d2-4e14-a6da-ee15b04ccb6e'),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            width: sizeH * 10,
                            height: sizeV * 5,
                            child: ElevatedButton(
                              onPressed: () async {
                                Provider.of<ProfileViewModel>(context,
                                        listen: false)
                                    .pathAvatar = Provider.of<AuthenticService>(
                                        context,
                                        listen: false)
                                    .loggedInUser
                                    .avatarUrl;

                                showImageSourceActionSheet(context);
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.zero),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(sizeV * 2.5),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        whiteColor),
                                overlayColor: MaterialStateProperty.all<Color>(
                                    greenLightProfile),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: sizeV * 2.8,
                                  color: const Color(0xFF404040),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: sizeH * 2.5,
              ),
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: sizeH * 6,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: sizeH * 1,
              ),
              Divider(
                color: Colors.grey,
                height: sizeH * 0.65,
                thickness: sizeH / 2,
                indent: sizeH * 10,
                endIndent: sizeH * 10,
              ),
              SizedBox(
                height: sizeH * 2,
              ),
              ProfileCard(
                text: "My profile",
                prefixIconData: Icons.account_circle_rounded,
                color: const Color(0xFFE4F3EA),
                iconColor: const Color(0xFF66B983),
                onTap: () {
                  Navigator.pushNamed(context, Routes.profileInformationScreen);
                },
              ),
              ProfileCard(
                text: "Setting",
                prefixIconData: Icons.settings,
                color: const Color(0xFFDDF5F4),
                iconColor: const Color(0xFF03B0A9),
                onTap: () {
                  Navigator.pushNamed(context, Routes.settingScreen);
                },
              ),
              ProfileCard(
                text: "Change Password",
                prefixIconData: Icons.lock,
                color: const Color(0xFFFFF6E4),
                iconColor: const Color(0xFFFEBF43),
                onTap: () {
                  Navigator.pushNamed(context, Routes.changePasswordScreen);
                },
              ),
              ProfileCard(
                text: "Help Center",
                prefixIconData: Icons.help,
                color: const Color(0xFFDBD2F6),
                iconColor: const Color(0xFF9B81E5),
                onTap: () {
                  DateTime time =
                      DateTime.now().add(const Duration(minutes: 1));
                  Provider.of<NotificationService>(context, listen: false)
                      .sheduledNotification(
                    1,
                    "Remind",
                    "Duc Trung đi ngủ",
                    time,
                  );
                },
              ),
              ProfileCardLogout(
                text: "Log out",
                prefixIconData: Icons.arrow_forward_ios,
                color: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFFE7E60),
                onTap: () async {
                  Provider.of<HistoryWorkoutViewModel>(context, listen: false)
                      .reset();
                  Provider.of<ChangePasswordViewModel>(context, listen: false)
                      .reset();
                  Provider.of<BMIHistoryViewModel>(context, listen: false)
                      .resetInfo();
                  Provider.of<WaterViewModel>(context, listen: false).reset();
                  if (authService.loginType == 1) {
                    await authService.signOut(context);
                  } else {
                    await Provider.of<GoogleSignInProvider>(context,
                            listen: false)
                        .logOutGoogle(context);
                  }
                },
              ),
              SizedBox(
                height: sizeH * 3.5,
              ),
              Center(
                child: Image.asset(
                  'assets/images/logos/logo.png',
                  scale: sizeH / 2.5,
                ),
              ),
              IconButton(
                onPressed: () async {},
                icon: const Icon(Icons.access_alarm),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showImageSourceActionSheet(contextRef) async {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: contextRef,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                Provider.of<ProfileViewModel>(context, listen: false)
                    .selectImageSource(ImageSource.camera, contextRef);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                Provider.of<ProfileViewModel>(context, listen: false)
                    .selectImageSource(ImageSource.gallery, contextRef);
              },
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: contextRef,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ProfileViewModel>(context, listen: false)
                  .selectImageSource(ImageSource.camera, contextRef);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              Provider.of<ProfileViewModel>(context, listen: false)
                  .selectImageSource(ImageSource.gallery, contextRef);
            },
          ),
        ]),
      );
    }
  }
}
