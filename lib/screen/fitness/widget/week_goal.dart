import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';

class WeekGoal extends StatelessWidget {
  const WeekGoal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: metalGreyColor,
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // change position of shadow
          )
        ],
      ),
      height: sizeV * 15,
      width: sizeH * 95,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Text(
                  'WEEK GOAL',
                  style: oBlackTitle,
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              childAspectRatio: 1.3,
              children: const [
                CustomeDate(text: '20'),
                CustomeDate(text: '21'),
                CustomeDate(text: '22'),
                CustomeDate(text: '23'),
                CustomeDate(text: '24'),
                CustomeDate(text: '25'),
                CustomeDate(text: '26'),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomeDate extends StatelessWidget {
  final String text;
  const CustomeDate({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: grey1,
        shape: BoxShape.circle,
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          text,
          style: oSubtitle,
        ),
      ),
    );
  }
}
