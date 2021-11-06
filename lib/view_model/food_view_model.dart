import 'package:flutter/cupertino.dart';
import 'package:wecare_flutter/constants.dart';

class FoodViewModel extends ChangeNotifier {
  final List<String> _listFood = ['banana', 'appple'];

  List<Widget>? searchFood(value) {
    _listFood
        .map((e) => {
              Container(
                height: 50,
                color: primaryColor,
                child: Text(value),
              )
            })
        .toList();
  }

  List<String> get listFood => _listFood;

  String? _search;

  get stringSearch => _search;

  set stringSearch(value) {
    _search = value;
    notifyListeners();
  }
}
