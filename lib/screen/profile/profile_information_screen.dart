import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/date_formatter.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/profile/widgets/button.dart';
import 'package:wecare_flutter/screen/profile/widgets/profile_info_text_field_text.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/edit_profile_view_model.dart';
import 'package:wecare_flutter/view_model/home_vm/bmi_view_model.dart';

class ProfileInformationScreen extends StatelessWidget {
  const ProfileInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final EditProfileViewModel editProfileViewModel =
        Provider.of<EditProfileViewModel>(context, listen: true);
    final AuthenticService authenticService =
        Provider.of<AuthenticService>(context);
    final BMIHistoryViewModel bmiHistoryViewModel =
        Provider.of<BMIHistoryViewModel>(context);

    //! Null check operator
    TimeOfDay currenSleepTime = TimeOfDay.fromDateTime(
        authenticService.loggedInUser.sleepTime ?? DateTime(2021, 1, 1, 10, 0));
    print(currenSleepTime);
    TimeOfDay currenWakeupTime = TimeOfDay.fromDateTime(
        authenticService.loggedInUser.wakeupTime ?? DateTime(2021, 1, 1, 7, 0));
    print(currenWakeupTime);

    DateTime? birthday = authenticService.loggedInUser.birthDay;
    String? dateOfBirth =
        DateFormat('dd - MM - yyyy').format(birthday ?? DateTime.now());

    String gender = '';
    switch (authenticService.loggedInUser.gender) {
      case true:
        gender = 'Male';
        break;
      case false:
        gender = 'Female';
        break;
    }

    void _clearInvalidInfo() {
      if (editProfileViewModel.isValidName == false) {
        editProfileViewModel.nameController.clear();
      }
      if (editProfileViewModel.isValidHeight == false) {
        editProfileViewModel.heightController.clear();
      }
      if (editProfileViewModel.isValidWeight == false) {
        editProfileViewModel.weightController.clear();
      }
    }

    Future<bool> _onBackPressed() async {
      return await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text(
                    "You haven't submitted information yet, are you sure you want to exit?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                      editProfileViewModel.nameController.clear();
                      editProfileViewModel.heightController.clear();
                      editProfileViewModel.weightController.clear();
                    },
                    child: const Text('Leave'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text('Stay'),
                  ),
                ],
              );
            },
          ) ?? //* The ?? stands for "if null"
          //* This means if the showDialog is null than showDialog equal to "false"
          false;
    }

    Future<void> _onExitPressed() async {
      final _isConfirmed = await _onBackPressed();
      if (_isConfirmed) {
        Navigator.of(context).pop();
      }
    }

    return SafeArea(
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.black),
            leading: IconButton(
              onPressed: () {
                _onExitPressed();
              },
              icon: const Icon(Icons.arrow_back_ios_new),
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
                    text: "Name",
                  ),
                  ProfileInfoTextField(
                    hintText: '${authenticService.loggedInUser.name}',
                    suffixIconData: Icons.clear,
                    textInputType: TextInputType.name,
                    list: const [],
                    maxlength: 20,
                    onTap: () {
                      editProfileViewModel.nameController.clear();
                    },
                    textController: editProfileViewModel.nameController,
                    validator: (value) {
                      return editProfileViewModel.nameValidator(value);
                    },
                    readOnly: false,
                  ),
                  const Title(
                    text: "Date of Birth",
                  ),
                  ProfileInfoTextField(
                    hintText: dateOfBirth,
                    suffixIconData: Icons.date_range_outlined,
                    textInputType: TextInputType.datetime,
                    list: [DateInputFormatter()],
                    validator: (value) => '',
                    onTap: () {},
                    readOnly: true,
                  ),
                  const Title(
                    text: "Gender",
                  ),
                  ProfileInfoTextField(
                    hintText: gender,
                    textInputType: TextInputType.datetime,
                    list: [DateInputFormatter()],
                    validator: (value) => '',
                    readOnly: true,
                  ),
                  SizedBox(
                    height: sizeV * 2,
                  ),
                  Text(
                    "Contact",
                    style: profileInfoText,
                  ),
                  const Title(
                    text: "Email",
                  ),
                  ProfileInfoTextField(
                    hintText: '${authenticService.loggedInUser.email}',
                    textInputType: TextInputType.emailAddress,
                    validator: (value) => '',
                    readOnly: true,
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
                              hintText:
                                  '${authenticService.loggedInUser.weight}',
                              suffixIconData: Icons.clear,
                              onTap: () {
                                editProfileViewModel.weightController.clear();
                              },
                              textController:
                                  editProfileViewModel.weightController,
                              textInputType: TextInputType.phone,
                              list: const [],
                              validator: (value) =>
                                  editProfileViewModel.weightValidator(value!),
                              readOnly: false,
                              onChanged: () {
                                if (editProfileViewModel
                                    .weightController.text.isEmpty) {
                                  try {
                                    editProfileViewModel.weightController.text =
                                        authenticService.loggedInUser.weight
                                            .toString();
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                }
                              },
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
                              hintText:
                                  '${authenticService.loggedInUser.height}',
                              suffixIconData: Icons.clear,
                              textController:
                                  editProfileViewModel.heightController,
                              onTap: () {
                                editProfileViewModel.heightController.clear();
                              },
                              textInputType: TextInputType.phone,
                              list: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) =>
                                  editProfileViewModel.heightValidator(value!),
                              readOnly: false,
                              onChanged: () {
                                if (editProfileViewModel
                                    .heightController.text.isEmpty) {
                                  try {
                                    editProfileViewModel.heightController.text =
                                        authenticService.loggedInUser.height
                                            .toString();
                                  } catch (e) {
                                    Fluttertoast.showToast(msg: e.toString());
                                  }
                                }
                              },
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
                              hintText: currenWakeupTime.format(context),
                              suffixIconData: Icons.access_time,
                              onTap: () {
                                editProfileViewModel.showWakeupPicker(context);
                              },
                              textController:
                                  editProfileViewModel.wakeupTimeController,
                              textInputType: TextInputType.phone,
                              list: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) => '',
                              readOnly: true,
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
                              hintText: currenSleepTime.format(context),
                              suffixIconData: Icons.access_time,
                              onTap: () {
                                editProfileViewModel.showSleepPicker(context);
                              },
                              textController:
                                  editProfileViewModel.sleepTimeController,
                              textInputType: TextInputType.datetime,
                              list: [FilteringTextInputFormatter.digitsOnly],
                              validator: (value) => '',
                              readOnly: true,
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
                        onTap: () async {
                          if (editProfileViewModel.isValidName == false ||
                              editProfileViewModel.isValidWeight == false ||
                              editProfileViewModel.isValidHeight == false) {
                            Fluttertoast.showToast(
                                msg: 'Please check you input information!');
                            _clearInvalidInfo();
                          } else {
                            await editProfileViewModel
                                .updateUserDatatoFirestore(context);
                            editProfileViewModel.updateToLoggedInUser(context);
                            if (editProfileViewModel
                                    .heightController.text.isNotEmpty ||
                                editProfileViewModel
                                    .weightController.text.isNotEmpty) {
                              await bmiHistoryViewModel
                                  .pushRatioToFirestore(context);
                            }
                            Navigator.pop(context);
                          }
                        },
                        color: primaryColor,
                        textColor: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
