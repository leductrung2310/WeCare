import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_button.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_input_infor_text_field.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_sizebox.dart';

class RegisterUpdateInfoScreen extends StatelessWidget {
  const RegisterUpdateInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 0),
                  child: Text(
                    "Almost There",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Let's us know about you",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const RegisterSizebox(text: "Date of Birth"),
                RegisterInputInfoTextField(
                  hintText: "dd/mm/yyyy",
                  prefixIconData: Icons.date_range,
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.number,
                  list: [DateInputFormatter()],
                ),
                const RegisterSizebox(text: "Height (cm)"),
                RegisterInputInfoTextField(
                  hintText: "Height",
                  prefixIconData: Icons.emoji_people,
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.number,
                  list: [ThousandsFormatter()],
                ),
                const RegisterSizebox(text: "Weight (kg)"),
                RegisterInputInfoTextField(
                  hintText: "Weight",
                  prefixIconData: Icons.emoji_people,
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.number,
                  list: [ThousandsFormatter()],
                ),
                const RegisterSizebox(text: "Gender"),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                            'assets/images/authentication/gender_mr.png'),
                        iconSize: 75,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                            'assets/images/authentication/gender_ms.png'),
                        iconSize: 75,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: RegisterButton(
                    text: "Let's go",
                    onTap: (value) {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
