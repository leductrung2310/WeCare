import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/authentication/login/widget/login_with_button.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_button.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_input_password_text_field.dart';
import 'package:wecare_flutter/screen/authentication/register/widget/register_input_text_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(120),
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
                      topLeft: Radius.circular(120),
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
                        RegisterInputTextField(
                          hintText: "Name",
                          prefixIconData: Icons.person,
                          suffixIconData: Icons.clear,
                          obscureText: false,
                          onChanged: (value) {},
                        ),
                        RegisterInputTextField(
                          hintText: "Email",
                          prefixIconData: Icons.email,
                          suffixIconData: Icons.clear,
                          obscureText: false,
                          onChanged: (value) {},
                        ),
                        RegisterInputPasswordTextField(
                          hintText: "Password",
                          prefixIconData: Icons.lock,
                          suffixIconData: Icons.visibility_off,
                          obscureText: true,
                          onChanged: (value) {},
                        ),
                        RegisterInputPasswordTextField(
                          hintText: "Password",
                          prefixIconData: Icons.lock,
                          suffixIconData: Icons.visibility_off,
                          obscureText: true,
                          onChanged: (value) {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, //Center Row contents horizontally,
                          crossAxisAlignment: CrossAxisAlignment
                              .center, //Center Row contents vertically,
                          children: const <Widget>[],
                        ),
                        RegisterButton(
                          text: "Sign up",
                          onTap: (value) {},
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account? ",
                              style: TextStyle(
                                color: accentColor,
                                fontSize: 18,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Login",
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
