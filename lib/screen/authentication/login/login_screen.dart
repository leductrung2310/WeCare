import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/home_view_mode.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_button.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_input_text_field.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_with_button.dart';
import 'package:wecare_flutter/screen/authentication/register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(120),
                  ),
                  color: primaryColor,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo1.png',
                    scale: 1.3,
                  ),
                ),
              ),
              Container(
                color: primaryColor,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(120),
                    ),
                    color: Color(0xFFffffff),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        const SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            LoginInputTextField(
                              hintText: "Email",
                              prefixIconData: Icons.email,
                              suffixIconData: loginViewModel.isValid
                                  ? Icons.check
                                  : Icons.keyboard,
                              obscureText: false,
                              onChanged: (value) {
                                loginViewModel.isValidEmail(value);
                              },
                            ),
                            LoginInputTextField(
                              hintText: "Password",
                              prefixIconData: Icons.lock,
                              suffixIconData: loginViewModel.isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              obscureText:
                                  loginViewModel.isVisible ? false : true,
                              onChanged: (value) {},
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                right: 20,
                                top: 5,
                              ),
                              child: Text(
                                "Forgot password?",
                                style: TextStyle(
                                  color: accentColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LoginButton(
                          text: "Login ",
                          onTap: () {
                            Provider.of<LoginViewModel>(context, listen: false)
                                .circular = !Provider.of<LoginViewModel>(
                                    context,
                                    listen: false)
                                .circular;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Or",
                          style: TextStyle(
                            fontSize: 20,
                            color: accentColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: const <Widget>[
                            LoginWithButton(
                              icon: FontAwesomeIcons.facebook,
                              size: 75,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            LoginWithButton(
                              icon: FontAwesomeIcons.google,
                              size: 75,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "If you don't have an Account? ",
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 18,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (builder) =>
                                        const RegisterScreen()));
                              },
                              child: const Text(
                                "SignUp",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
