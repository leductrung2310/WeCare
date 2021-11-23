import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/home/widgets/tools/appbar.dart';

class CaloriesScreen extends StatelessWidget {
  const CaloriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(
            context, caloriesColor, 'Your Activity', const SizedBox.shrink()),
        body: SingleChildScrollView(
          child: Column(
            
          ),
        ),
      ),
    );
  }
}
