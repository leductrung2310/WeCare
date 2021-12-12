import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_input_text_field.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';
import 'package:wecare_flutter/screen/onboarding_screen/widgets/custom_button.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeV = SizeConfig.blockSizeV!;
    final loginViewModel = Provider.of<LoginViewModel>(context);

    final emailFoucs = FocusNode();
    return SafeArea(
      child: Scaffold(
        appBar:
            customAppBar(context, Colors.black, '', const SizedBox.shrink()),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: sizeV * 2),
              Image.asset(
                'assets/images/authentication/forget_password.png',
              ),
              SizedBox(height: sizeV * 2),
              Text(
                'Forget Your Password?',
                style: oTitle,
              ),
              SizedBox(height: sizeV * 2),
              RegisterInputTextField(
                  hintText: 'Enter your email',
                  prefixIconData: Icons.email,
                  suffixIconData: Icons.clear,
                  obscureText: false,
                  onChanged: (value) {},
                  textController: loginViewModel.sendmailController,
                  validator: (value) {
                    return loginViewModel.emailValidator(value);
                  },
                  onFieldSubmitted: (value) {},
                  focusNode: emailFoucs),
              SizedBox(height: sizeV * 2),
              loginViewModel.isLoadingSendEmail
                  ? const CircularProgressIndicator()
                  : CustomTextBtn(
                      name: 'Send Email',
                      onPressed: () async {
                        String result =
                            await loginViewModel.onChangePasswordClick();
                        if (result == 'Please check your email') {
                          Fluttertoast.showToast(msg: result);
                          Navigator.pop(context);
                          loginViewModel.resetSendEmail();
                        } else if (result.isNotEmpty) {
                          Fluttertoast.showToast(msg: result);
                        }
                      },
                      color: primaryColor,
                      textColor: whiteColor,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
