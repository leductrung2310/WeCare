import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_button.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_input_password_text_field.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_input_text_field.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/register_view_model.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final nameFocus = FocusNode();
    final emailFocus = FocusNode();
    final passwordFocus = FocusNode();
    final confirmPasswordFocus = FocusNode();
    final registerViewModel = Provider.of<RegisterViewModel>(context);

    final authService = Provider.of<AuthenticService>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(sizeV * 14.62),
                  ),
                  color: primaryColor,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logos/logo1.png',
                    scale: sizeH / 3.165,
                  ),
                ),
              ),
              Container(
                color: primaryColor,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(sizeV * 14.62),
                    ),
                    color: const Color(0xFFffffff),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(sizeH * 5),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: sizeV * 4.5,
                        ),
                        RegisterInputTextField(
                          hintText: "Name",
                          prefixIconData: Icons.person,
                          suffixIconData: Icons.clear,
                          obscureText: false,
                          onChanged: (value) {},
                          textController: registerViewModel.nameController,
                          validator: (value) {
                            return Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .nameValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            emailFocus.requestFocus();
                          },
                          focusNode: nameFocus,
                        ),
                        RegisterInputTextField(
                          hintText: "Email",
                          prefixIconData: Icons.email,
                          suffixIconData: registerViewModel.isValid
                              ? Icons.check
                              : Icons.clear,
                          obscureText: false,
                          onChanged: (value) {
                            registerViewModel.isValidEmail(value);
                          },
                          textController: registerViewModel.emailController,
                          validator: (value) {
                            return Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .emailValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            passwordFocus.requestFocus();
                          },
                          focusNode: emailFocus,
                        ),
                        RegisterInputPasswordTextField(
                          hintText: "Password",
                          prefixIconData: Icons.lock,
                          suffixIconData: registerViewModel.isVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          obscureText:
                              registerViewModel.isVisible ? false : true,
                          onChanged: (value) {},
                          textController: registerViewModel.passwordController,
                          validator: (value) {
                            return Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .passwordValidator(value);
                          },
                          onFieldSubmitted: (value) {
                            confirmPasswordFocus.requestFocus();
                          },
                          focusNode: passwordFocus,
                        ),
                        RegisterInputPasswordTextField(
                          hintText: "Confirm Password",
                          prefixIconData: Icons.lock,
                          suffixIconData: registerViewModel.isConfirmVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          obscureText:
                              registerViewModel.isConfirmVisible ? false : true,
                          onChanged: (value) {},
                          textController:
                              registerViewModel.confirmPasswordController,
                          validator: (value) {
                            return Provider.of<RegisterViewModel>(context,
                                    listen: false)
                                .passwordRepeatValidator(value);
                          },
                          onFieldSubmitted: (value) {},
                          focusNode: confirmPasswordFocus,
                        ),
                        SizedBox(
                          height: sizeH * 5,
                        ),
                        // authService.isLoading
                        //     ? const CircularProgressIndicator() :
                        authService.isLoading
                            ? const CircularProgressIndicator()
                            : RegisterButton(
                                text: "Sign up",
                                onTap: () async {
                                  if (registerViewModel.onNextClick()) {
                                    authService.createUserWithEmailAndPassword(
                                      context,
                                      registerViewModel.emailController.text,
                                      registerViewModel.passwordController.text,
                                    );
                                  }
                                },
                                textColor: Colors.white,
                                color: primaryColor,
                              ),
                        SizedBox(
                          height: sizeH * 3.63,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: authTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Login",
                                style: authTextStyle1,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
