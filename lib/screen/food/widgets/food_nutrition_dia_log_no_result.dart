import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class FoodNoResult extends StatelessWidget {
  const FoodNoResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(sizeH),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    return Container(
      height: sizeV * 32,
      width: 360,
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
          Icon(
            Icons.info_outline,
            size: sizeH * 24,
            color: primaryColor,
          ),
          Text(
            "Whoops!",
            style: TextStyle(
                fontSize: sizeH * 5.5,
                fontWeight: FontWeight.w700,
                fontFamily: "Poppins"),
          ),
          Text(
            "Something went wrong.",
            style: TextStyle(
              fontSize: sizeH * 4.5,
              fontFamily: "Poppins",
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: sizeV,
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
          // Container(
          //   height: sizeV * 15,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.rectangle,
          //     color: primaryColor,
          //     borderRadius: BorderRadius.only(
          //       topLeft: Radius.circular(sizeH * 2.5),
          //       topRight: Radius.circular(sizeH * 2.5),
          //     ),
          //   ),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Icon(
          //         Icons.error,
          //         color: Colors.redAccent,
          //         size: sizeH * 8,
          //       ),
          //       SizedBox(
          //         width: sizeV,
          //       ),
          //       Text(
          //         "No Result",
          //         style: TextStyle(
          //             fontSize: sizeH * 6,
          //             fontWeight: FontWeight.w600,
          //             fontFamily: "Poppins"),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

final text = TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
