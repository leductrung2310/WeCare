import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/screen/profile/widgets/button.dart';
import 'package:wecare_flutter/screen/profile/widgets/change_password_text_field_password.dart';
import 'package:wecare_flutter/view_model/change_password_view_model.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;

    final oldPasswordFocus = FocusNode();
    final newPasswordFocus = FocusNode();
    final confirmPasswordFocus = FocusNode();
    final changePasswordViewModel =
        Provider.of<ChangePasswordViewModel>(context);

    return SafeArea(
      child: Scaffold(
        appBar:
            customAppBar(context, Colors.black, '', const SizedBox.shrink()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              titleCustom(context, "Current Password"),
              ChangePasswordInputPasswordTextField(
                hintText: "Current Password",
                suffixIconData: changePasswordViewModel.isVisible
                    ? Icons.visibility_off
                    : Icons.visibility,
                obscureText: changePasswordViewModel.isVisible,
                textController: changePasswordViewModel.oldPasswordController,
                validator: (value) {
                  return changePasswordViewModel.passwordValidator(value);
                },
                onFieldSubmitted: (value) {
                  newPasswordFocus.requestFocus();
                },
                focusNode: oldPasswordFocus,
                onTap: () {
                  Provider.of<ChangePasswordViewModel>(context, listen: false)
                      .isVisible = !Provider.of<ChangePasswordViewModel>(
                          context,
                          listen: false)
                      .isVisible;
                },
              ),
              titleCustom(context, "New Password"),
              ChangePasswordInputPasswordTextField(
                hintText: "New Password",
                suffixIconData: changePasswordViewModel.isVisibleOne
                    ? Icons.visibility_off
                    : Icons.visibility,
                obscureText: changePasswordViewModel.isVisibleOne,
                textController: changePasswordViewModel.newPasswordController,
                validator: (value) {
                  return changePasswordViewModel.passwordValidator(value);
                },
                onFieldSubmitted: (value) {
                  confirmPasswordFocus.requestFocus();
                },
                focusNode: newPasswordFocus,
                onTap: () {
                  Provider.of<ChangePasswordViewModel>(context, listen: false)
                      .isVisibleOne = !Provider.of<ChangePasswordViewModel>(
                          context,
                          listen: false)
                      .isVisibleOne;
                },
              ),
              titleCustom(context, "Confirm New Password"),
              ChangePasswordInputPasswordTextField(
                hintText: "Confirm new Password",
                suffixIconData: changePasswordViewModel.isVisibleTow
                    ? Icons.visibility_off
                    : Icons.visibility,
                obscureText: changePasswordViewModel.isVisibleTow,
                textController:
                    changePasswordViewModel.confirmPasswordController,
                validator: (value) {
                  return changePasswordViewModel.passwordValidator(value);
                },
                onFieldSubmitted: (value) {},
                focusNode: confirmPasswordFocus,
                onTap: () {
                  Provider.of<ChangePasswordViewModel>(context, listen: false)
                      .isVisibleTow = !Provider.of<ChangePasswordViewModel>(
                          context,
                          listen: false)
                      .isVisibleTow;
                },
              ),
              SizedBox(height: sizeV * 35),
              Align(
                alignment: Alignment.bottomCenter,
                child: ProfileButton(
                  color: primaryColor,
                  textColor: whiteColor,
                  text: "Save",
                  onTap: () async {
                    final result =
                        await changePasswordViewModel.onChangePasswordClick();
                    if (result.isNotEmpty) {
                      Fluttertoast.showToast(
                        msg: result,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    } else {
                      Navigator.pushNamed(
                        context,
                        Routes.changePasswordSuccessScreen,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleCustom(BuildContext context, String text) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(left: sizeH * 5, top: sizeV * 1.5),
        child: Text(
          text,
          style: profileText,
        ),
      ),
    );
  }
}
