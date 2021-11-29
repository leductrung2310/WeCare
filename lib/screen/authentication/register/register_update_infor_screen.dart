import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_button.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_input_infor_text_field.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_sizebox.dart';
import 'package:wecare_flutter/view_model/register_view_model.dart';

class RegisterUpdateInfoScreen extends StatelessWidget {
  const RegisterUpdateInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    //double sizeV = SizeConfig.blockSizeV!;

    final registerViewModel = Provider.of<RegisterViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(sizeH * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: sizeH * 5, top: 0),
                  child: Text(
                    "Almost There\nLet's us know about you",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: sizeH * 6.8,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const RegisterSizebox(text: "Date of Birth"),
                RegisterInputInfoTextField(
                  controller: registerViewModel.dateOfBirthController,
                  hintText: "dd/mm/yyyy",
                  prefixIconData: Icons.date_range,
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.number,
                  list: [DateInputFormatter()],
                ),
                const RegisterSizebox(text: "Height (cm)"),
                RegisterInputInfoTextField(
                  controller: registerViewModel.heightController,
                  hintText: "Height",
                  prefixIconData: Icons.emoji_people,
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.number,
                  list: [ThousandsFormatter()],
                ),
                const RegisterSizebox(text: "Weight (kg)"),
                RegisterInputInfoTextField(
                  controller: registerViewModel.weightController,
                  hintText: "Weight",
                  prefixIconData: Icons.emoji_people,
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.number,
                  list: [ThousandsFormatter()],
                ),
                const RegisterSizebox(text: "Gender"),
                SizedBox(
                  height: sizeH * 2.75,
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: sizeH * 2.45, bottom: sizeH * 3.65),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Image.asset(
                      //       'assets/images/authentication/gender_mr.png'),
                      //   iconSize: sizeH * 18.23,
                      // ),
                      CustomRadio(
                        color:
                            Provider.of<RegisterViewModel>(context).gender == 1
                                ? primaryColor
                                : Colors.white,
                        widget: Image.asset(
                            'assets/images/authentication/gender_mr.png'),
                        check: true,
                      ),
                      SizedBox(
                        width: sizeH * 12.15,
                      ),
                      CustomRadio(
                        color:
                            Provider.of<RegisterViewModel>(context).gender == 2
                                ? primaryColor
                                : Colors.white,
                        widget: Image.asset(
                            'assets/images/authentication/gender_ms.png'),
                        check: false,
                      ),
                      // IconButton(
                      //   onPressed: () {},
                      //   icon: Image.asset(
                      //       'assets/images/authentication/gender_ms.png'),
                      //   iconSize: sizeH * 18.23,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: sizeH * 2.75,
                ),
                Center(
                  child: registerViewModel.isLoading == true
                      ? const CircularProgressIndicator()
                      : RegisterButton(
                          text: "Let's go",
                          onTap: () {
                            registerViewModel.completeRegister(context);
                          },
                          textColor: Colors.white,
                          color: primaryColor,
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

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    Key? key,
    required this.color,
    required this.widget,
    required this.check,
  }) : super(key: key);
  final Color color;
  final Widget widget;
  final bool check;
  @override
  Widget build(BuildContext context) {
    final registerViewModel =
        Provider.of<RegisterViewModel>(context, listen: false);
    return Card(
      color: color,
      shape: const CircleBorder(),
      child: IconButton(
        splashRadius: 45,
        onPressed: () {
          if (check && registerViewModel.gender == 1 ||
              !check && registerViewModel.gender == 2) {
            registerViewModel.gender = 0;
          } else {
            if (check) {
              registerViewModel.gender = 1;
            } else {
              registerViewModel.gender = 2;
            }
          }
        },
        icon: widget,
        iconSize: 75,
      ),
    );
  }
}
