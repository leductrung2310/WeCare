import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/screen/profile/widgets/setting_card.dart';
import 'package:wecare_flutter/screen/profile/widgets/setting_card_switch.dart';
import 'package:wecare_flutter/view_model/setting_view_model.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settingViewModel =
        Provider.of<SettingViewModel>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SettingCard(
                preText: "Language",
                sufText: "English",
                prefixIconData: Icons.language,
                color: Color(0xFFFFF4D8),
                iconColor: Color(0xFFFBC12D),
              ),
              SettingSwitchCard(
                prefixIconData: Icons.notifications,
                preText: "Notifications",
                sufText: "",
                color: const Color(0xFFB2E8FF),
                iconColor: const Color(0xFF12ADDE),
                value: Provider.of<SettingViewModel>(context).isNotifications,
                onChanged: (value) {
                  settingViewModel.isNotifications =
                      !settingViewModel.isNotifications;
                },
              ),
              SettingSwitchCard(
                prefixIconData: Icons.dark_mode,
                preText: "Dark Mode",
                sufText: "",
                color: const Color(0xFF91BDFF),
                iconColor: const Color(0xFF3A5FE1),
                value: Provider.of<SettingViewModel>(context).isDarkMode,
                onChanged: (value) {
                  settingViewModel.isDarkMode = !settingViewModel.isDarkMode;
                },
              ),
              const SettingCard(
                preText: "Fitness",
                sufText: "",
                prefixIconData: Icons.fitness_center,
                color: Color(0xFFE4F3EA),
                iconColor: Color(0xFF66B983),
              ),
              const SettingCard(
                preText: "Rate the App",
                sufText: "",
                prefixIconData: Icons.thumb_up,
                color: Color(0xFFF5C8C8),
                iconColor: Color(0xFFFC4B4B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
