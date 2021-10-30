import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:date_field/date_field.dart';
import 'package:wecare_flutter/screen/profile/widgets/button.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_info_text_field_text.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          elevation: 0,
          toolbarHeight: sizeV * 7,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeH * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Basic Detail",
                  style: profileInfoText,
                ),
                const Title(
                  text: "Full Name",
                ),
                ProfileInfoTextField(
                  hintText: "Full Name",
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.name,
                  list: const [],
                  // textController: textController,
                  // validator: validator,
                  // onFieldSubmitted: onFieldSubmitted,
                  // focusNode: focusNode,
                  onTap: () {},
                ),
                const Title(
                  text: "Date of Birth",
                ),
                ProfileInfoTextField(
                  hintText: "hintText",
                  suffixIconData: Icons.date_range_outlined,
                  textInputType: TextInputType.datetime,
                  list: [DateInputFormatter()],
                  // textController: textController,
                  // validator: validator,
                  // onFieldSubmitted: onFieldSubmitted,
                  // focusNode: focusNode,
                  onTap: () {
                    _getDate(context);
                  },
                ),
                const Title(
                  text: "Gender",
                ),
                ProfileInfoTextField(
                  hintText: "Gender",
                  suffixIconData: Icons.arrow_drop_down_sharp,
                  textInputType: TextInputType.datetime,
                  list: [DateInputFormatter()],
                  // textController: textController,
                  // validator: validator,
                  // onFieldSubmitted: onFieldSubmitted,
                  // focusNode: focusNode,
                  onTap: () {},
                ),
                SizedBox(
                  height: sizeV * 2,
                ),
                Text(
                  "Contact",
                  style: profileInfoText,
                ),
                const Title(
                  text: "Mobile Number",
                ),
                ProfileInfoTextField(
                  hintText: "Mobile Number",
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.phone,
                  list: [FilteringTextInputFormatter.digitsOnly],
                  // textController: textController,
                  // validator: validator,
                  // onFieldSubmitted: onFieldSubmitted,
                  // focusNode: focusNode,
                  onTap: () {},
                ),
                const Title(
                  text: "Email",
                ),
                ProfileInfoTextField(
                  hintText: "Email",
                  suffixIconData: Icons.clear,
                  textInputType: TextInputType.emailAddress,
                  // textController: textController,
                  // validator: validator,
                  // onFieldSubmitted: onFieldSubmitted,
                  // focusNode: focusNode,
                  onTap: () {},
                ),
                SizedBox(
                  height: sizeV * 2,
                ),
                Text(
                  "Body",
                  style: profileInfoText,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Title(
                            text: "Weight (kg)",
                          ),
                          ProfileInfoTextField(
                            hintText: "Weight (kg)",
                            suffixIconData: Icons.clear,
                            onTap: () {},
                            textInputType: TextInputType.phone,
                            list: [FilteringTextInputFormatter.digitsOnly],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: sizeH * 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Title(
                            text: "Height (cm)",
                          ),
                          ProfileInfoTextField(
                            hintText: "Height (cm)",
                            suffixIconData: Icons.clear,
                            onTap: () {},
                            textInputType: TextInputType.phone,
                            list: [FilteringTextInputFormatter.digitsOnly],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: sizeH,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Title(
                            text: "Time to wake up",
                          ),
                          ProfileInfoTextField(
                            hintText: "Time to wake up",
                            suffixIconData: Icons.clear,
                            onTap: () {},
                            textInputType: TextInputType.phone,
                            list: [FilteringTextInputFormatter.digitsOnly],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: sizeH * 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Title(
                            text: "Time to sleep",
                          ),
                          ProfileInfoTextField(
                            hintText: "Time to sleep",
                            suffixIconData: Icons.clear,
                            onTap: () {},
                            textInputType: TextInputType.phone,
                            list: [FilteringTextInputFormatter.digitsOnly],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: sizeV * 2.5),
                  child: Center(
                    child: ProfileButton(
                        text: "Save",
                        onTap: () {},
                        color: primaryColor,
                        textColor: whiteColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getDate(BuildContext context) async {
    DateTime? _pickerdate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2121),
    );
  }
}

class Title extends StatelessWidget {
  const Title({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Padding(
      padding: EdgeInsets.only(
        bottom: sizeV / 8,
      ),
      child: Column(
        children: [
          SizedBox(height: sizeH * 2),
          Text(text, style: profileText),
        ],
      ),
    );
  }
}
