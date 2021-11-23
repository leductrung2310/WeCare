import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/model/wecare_user.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_card.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_card_logout.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

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

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFC),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sizeH * 9,
              ),
              Stack(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: sizeV * 9.75,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 8,
                                    color: Colors.grey,
                                    offset: Offset(3, 3))
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: sizeV * 2.6,
                              child: Icon(
                                Icons.camera_alt,
                                size: sizeV * 2.8,
                                color: const Color(0xFF404040),
                              ),
                            ),
                          ),
                        ),
                        radius: sizeV * 100 / 5,
                        backgroundImage: const AssetImage(
                            'assets/images/profile/avatar.png'),
                      ),
                    )),
              ]),
              SizedBox(
                height: sizeH * 2.5,
              ),
              Text(
                "John Wich",
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
                  Navigator.pushNamed(context, Routes.foodDetailScreen);
                },
              ),
              ProfileCardLogout(
                text: "Log out",
                prefixIconData: Icons.arrow_forward_ios,
                color: const Color(0xFFFFECE8),
                iconColor: const Color(0xFFFE7E60),
                onTap: () async {
                  await authService.signOutWithEmail(context);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
