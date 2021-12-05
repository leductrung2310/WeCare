import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class DiaLogInformation extends StatelessWidget {
  const DiaLogInformation({
    Key? key,
    required this.content,
  }) : super(key: key);

  final String content;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sizeH),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context, sizeH, sizeV),
    );
  }

  contentBox(context, sizeH, sizeV) {
    return Container(
      height: sizeV * 27,
      width: sizeV * 33,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(sizeH * 2.5),
          boxShadow: const [
            BoxShadow(color: Colors.grey, offset: Offset(0, 5), blurRadius: 10),
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logos/logo.png',
            scale: sizeH / 3,
          ),
          SizedBox(
            height: sizeV * 3,
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: sizeH * 4.5,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: sizeV * 3,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: SizedBox(
              width: sizeH * 30,
              height: sizeV * 5,
              child: Center(
                child: Text(
                  "OK",
                  style: TextStyle(
                      fontSize: sizeH * 5,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins"),
                ),
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(sizeH * 3),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

final text = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
