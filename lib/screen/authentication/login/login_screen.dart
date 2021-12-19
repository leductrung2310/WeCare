import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/routes.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_button.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_input_text_field.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_password_text_field.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_with_button.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/services/google_service.dart';
import 'package:wecare_flutter/view_model/register_view_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final passwordFocus = FocusNode();
    final loginViewModel = Provider.of<LoginViewModel>(context);
    final authService = Provider.of<AuthenticService>(context);
    final googleProvider =
        Provider.of<GoogleSignInProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: SizeConfig.screenHeight! * 0.28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(sizeV * 14.62),
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
                      topRight: Radius.circular(sizeV * 14.62),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            LoginInputTextField(
                              controller: loginViewModel.emailController,
                              hintText: "Email",
                              prefixIconData: Icons.email,
                              suffixIconData: loginViewModel.isValid
                                  ? Icons.check
                                  : Icons.keyboard,
                              obscureText: false,
                              onChanged: (value) {
                                loginViewModel.isValidEmail(value);
                              },
                              validator: (value) {
                                return loginViewModel.emailValidator(value);
                              },
                              inputType: TextInputType.emailAddress,
                              onFieldSubmitted: (value) {
                                passwordFocus.requestFocus();
                              },
                            ),
                            LoginInputPasswordTextField(
                              controller: loginViewModel.passwordController,
                              hintText: "Password",
                              prefixIconData: Icons.lock,
                              suffixIconData: loginViewModel.isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              obscureText:
                                  loginViewModel.isVisible ? false : true,
                              onChanged: (value) {},
                              validator: (value) {},
                              inputType: TextInputType.visiblePassword,
                              onFieldSubmitted: (value) {
                                return;
                              },
                              focusNode: passwordFocus,
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                  context, Routes.forgetpassword),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: sizeH * 5,
                                  top: sizeH * 1.215,
                                ),
                                child: const Text(
                                  "Forgot password?",
                                  style: TextStyle(
                                    color: accentColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeV * 2.5,
                        ),
                        authService.isLoading
                            ? const CircularProgressIndicator()
                            : LoginButton(
                                text: "Login ",
                                onTap: () async {
                                  authService.signInWithEmailAndPassword(
                                      context,
                                      loginViewModel.emailController.text,
                                      loginViewModel.passwordController.text);
                                },
                                textColor: Colors.white,
                                color: primaryColor,
                              ),
                        SizedBox(
                          height: sizeV * 3.3,
                        ),
                        Text(
                          "Or",
                          style: TextStyle(
                            fontSize: sizeH * 5,
                            color: accentColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: <Widget>[
                            LoginWithButton(
                              onPress: () {
                                authService.signInWithFacebook(context);
                              },
                              icon: FontAwesomeIcons.facebook,
                              size: sizeV * 9,
                            ),
                            SizedBox(
                              width: sizeH * 14.6,
                            ),
                            LoginWithButton(
                              onPress: () =>
                                  googleProvider.logInWithGoogle(context),
                              icon: FontAwesomeIcons.google,
                              size: sizeV * 9,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sizeV * 4.7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "If you don't have an Account? ",
                              style: authTextStyle,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Routes.register);
                                Provider.of<RegisterViewModel>(context,
                                        listen: false)
                                    .reset();
                              },
                              child: Text(
                                "SignUp",
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
