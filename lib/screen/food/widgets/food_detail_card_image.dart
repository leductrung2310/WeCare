import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';

class CardImageFood extends StatelessWidget {
  final String image;
  final String protein;
  final String carbo;
  final String fat;
  final String calo;
  const CardImageFood({
    Key? key,
    required this.image,
    required this.protein,
    required this.carbo,
    required this.fat,
    required this.calo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      height: sizeV * 25,
      width: sizeH * 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(sizeH * 4),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: sizeH,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(image),
            radius: sizeH * 18,
          ),
          SizedBox(
            width: sizeH * 6,
          ),
          Column(
            children: [
              SizedBox(
                height: sizeV * 6.5,
              ),
              Text(
                protein,
                style: styleOne,
              ),
              Text(
                "Protein",
                style: styleTwo,
              ),
              SizedBox(
                height: sizeV,
              ),
              Text(
                fat,
                style: styleOne,
              ),
              Text(
                "Fat",
                style: styleTwo,
              ),
            ],
          ),
          SizedBox(
            width: sizeH * 7.5,
          ),
          Column(
            children: [
              SizedBox(
                height: sizeV * 6.5,
              ),
              Text(
                carbo,
                style: styleOne,
              ),
              Text(
                "Carbo",
                style: styleTwo,
              ),
              SizedBox(
                height: sizeV,
              ),
              Text(
                calo,
                style: styleOne,
              ),
              Text(
                "Calories",
                style: styleTwo,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final styleOne = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 4,
  fontWeight: FontWeight.w600,
  fontFamily: "Poppins",
);

final styleTwo = TextStyle(
  fontSize: SizeConfig.blockSizeH! * 3,
  fontWeight: FontWeight.w400,
  fontFamily: "Poppins",
);
