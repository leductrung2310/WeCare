import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/profile/widgets/change_password_text_field_password.dart';
import 'package:wecare_flutter/view_model/change_password_view_model.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final oldPasswordFocus = FocusNode();
    final newPasswordFocus = FocusNode();
    final confirmPasswordFocus = FocusNode();
    final changePasswordViewModel =
        Provider.of<ChangePasswordViewModel>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: sizeH * 2.8, horizontal: sizeH * 5),
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
                  hintText: "Current Password",
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
                  hintText: "Current Password",
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
                SizedBox(height: sizeV * 45),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      width: sizeH * 65,
                      height: sizeV * 7.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(sizeV * 2.5),
                        gradient: const LinearGradient(colors: [
                          primaryColor,
                          greenLight,
                          primaryColor,
                        ]),
                      ),
                      child: Center(
                        child: Text(
                          "Save",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: sizeV * 2.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget titleCustom(BuildContext context, String text) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;

    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: EdgeInsets.only(top: sizeH * 3.5),
        child: Text(
          text,
          style: profileText,
        ),
      ),
    );
  }
}
