import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sizeH * 12,
              ),
              Stack(children: [
                Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: sizeV * 10.8,
                      backgroundColor: Colors.red,
                      child: CircleAvatar(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: sizeV * 2.6,
                            child: Icon(
                              Icons.camera_alt,
                              size: sizeV * 2.8,
                              color: Color(0xFF404040),
                            ),
                          ),
                        ),
                        radius: sizeV * 100 / 5,
                        backgroundImage: AssetImage(
                            'assets/images/authentication/gender_ms.png'),
                      ),
                    )),
              ]),
              // Stack(
              //   children: const [
              //   CircleAvatar(
              //     child: Align(
              //       alignment: Alignment.bottomRight,
              //       child: CircleAvatar(
              //         backgroundColor: Colors.white,
              //         radius: 12.0,
              //         child: Icon(
              //           Icons.camera_alt,
              //           size: 15.0,
              //           color: Color(0xFF404040),
              //         ),
              //       ),
              //     ),
              //   ),
              // ]),
            ],
          ),
        ),
      ),
    );
  }
}
