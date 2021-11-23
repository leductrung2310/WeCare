import 'package:flutter/material.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/fitness/widget/workouts_tab.dart';

class ABSWorkout extends StatelessWidget {
  const ABSWorkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(
                  text: "Dog",
                ),
                Tab(
                  text: "Dog",
                ),
                Tab(
                  text: "Bird",
                ),
                Tab(
                  text: "Trung",
                ),
                Tab(
                  text: "Thảo",
                ),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: Text(
                  "1",
                  style: TextStyle(fontSize: 52),
                ),
              ),
              Center(
                child: Text(
                  "2",
                  style: TextStyle(fontSize: 52),
                ),
              ),
              Center(
                child: Text(
                  "3",
                  style: TextStyle(fontSize: 52),
                ),
              ),
              Center(
                child: Text(
                  "4",
                  style: TextStyle(fontSize: 52),
                ),
              ),
              Center(
                child: Text(
                  "5",
                  style: TextStyle(fontSize: 52),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
