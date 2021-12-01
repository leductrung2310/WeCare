import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_card.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_card_logout.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/view_model/exercise/history_workout_view_model.dart';
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

    final authService = Provider.of<AuthenticService>(context);
    final currentUser = FirebaseAuth.instance.currentUser;

    String name = "Unknow User";
    if (authService.loggedInUser.name != null) {
      name = authService.loggedInUser.name!;
    } else if (currentUser!.displayName != null) {
      name = currentUser.displayName!;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFC),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sizeH * 9,
              ),
              CustomAvatar(
                sizeV: sizeV,
                sizeH: sizeH,
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
                  //Navigator.pushNamed(context, Routes.foodDetailScreen);
                },
              ),
              ProfileCardLogout(
                text: "Log out",
                prefixIconData: Icons.arrow_forward_ios,
                color: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFFE7E60),
                onTap: () async {
                  await authService.signOutWithEmail(context);
                  Provider.of<HistoryWorkoutViewModel>(context, listen: false)
                      .reset();
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
                onPressed: () async {
                  // DateTime time = DateTime.now().add(Duration(minutes: 1));
                  // Provider.of<NotificationService>(context, listen: false)
                  //     .sheduledNotification(
                  //   1,
                  //   "Remind",
                  //   "Duc Trung đi ngủ",
                  //   time,
                  // );
                  await Provider.of<ProfileViewModel>(context, listen: false)
                      .uploadImageToFirebase(context);
                  String url = await Provider.of<ProfileViewModel>(context,
                          listen: false)
                      .getUrlAvatar(context);
                  Provider.of<AuthenticService>(context, listen: false)
                      .setAvatar(url);
                  Provider.of<AuthenticService>(context, listen: false)
                      .updateUserAvatar(url);
                },
                icon: const Icon(Icons.access_alarm),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    Key? key,
    required this.sizeV,
    required this.sizeH,
  }) : super(key: key);

  final double sizeV;
  final double sizeH;

  @override
  Widget build(BuildContext context) {
    final profileViewModel =
        Provider.of<ProfileViewModel>(context, listen: false);

    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: sizeV * 9.75,
            backgroundColor: Colors.red,
            child: CircleAvatar(
              radius: sizeV * 100 / 5,
              backgroundImage: NetworkImage(Provider.of<AuthenticService>(
                          context,
                          listen: false)
                      .loggedInUser
                      .avatarUrl ??
                  'https://console.firebase.google.com/u/1/project/wecare-da049/storage/wecare-da049.appspot.com/files'),
              child: Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  width: sizeH * 10,
                  height: sizeV * 5,
                  child: ElevatedButton(
                    onPressed: () {
                      profileViewModel.showImageSourceActionSheet(context);
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.zero),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(sizeV * 2.5),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(whiteColor),
                      overlayColor:
                          MaterialStateProperty.all<Color>(greenLightProfile),
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
    );
  }
}
