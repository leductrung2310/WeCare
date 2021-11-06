import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/screen/food/widgets/food_search.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;
    String title = 'apple';
    String uri = 'https://spoonacular.com/cdn/ingredients_100x100/apple.jpg';
    print(uri);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: sizeV * 2.5,
              ),
              Stack(
                children: [
                  Positioned(
                    top: 90,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(sizeV * 4.5),
                          topRight: Radius.circular(sizeV * 4.5),
                        ),
                        color: grey1,
                      ),
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        height: sizeV * 100,
                        width: sizeH * 95,
                        color: Colors.transparent,
                        child: SearchBarCustom()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
