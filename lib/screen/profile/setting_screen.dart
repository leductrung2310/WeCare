import 'package:flutter/material.dart';
import 'package:wecare_flutter/screen/profile/widgets/setting_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              SettingCard(
                preText: "Language",
                sufText: "English",
                prefixIconData: Icons.language,
                color: Color(0xFFFFF4D8),
                iconColor: Color(0xFFFBC12D),
              ),
              SettingCard(
                preText: "Notifications",
                sufText: "",
                prefixIconData: Icons.notifications,
                color: Color(0xFFB2E8FF),
                iconColor: Color(0xFF12ADDE),
              ),
              SettingCard(
                preText: "Dark Mode",
                sufText: "",
                prefixIconData: Icons.dark_mode,
                color: Color(0xFF91BDFF),
                iconColor: Color(0xFF3A5FE1),
              ),
              SettingCard(
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
