import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants/constants.dart';
import 'package:wecare_flutter/screen/food/widgets/food_nutrition_dia_log.dart';
import 'package:wecare_flutter/screen/food/widgets/food_nutrition_dia_log_no_result.dart';
import 'package:wecare_flutter/services/authentic_service.dart';
import 'package:wecare_flutter/view_model/food/food_view_model.dart';

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double sizeH = SizeConfig.blockSizeH!;
    double sizeV = SizeConfig.blockSizeV!;

    final foodViewModel = Provider.of<FoodViewModel>(context, listen: false);
    final authentic = Provider.of<AuthenticService>(context, listen: false);

    settingEasyLoading();

    return FloatingSearchBar(
      automaticallyImplyBackButton: false,
      hint: 'Search food nutrition',
      hintStyle: TextStyle(
        fontSize: 16,
        fontFamily: "poppins",
        color: Colors.grey[700],
      ),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 500),
      borderRadius: BorderRadius.circular(15),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      openAxisAlignment: 0.0,
      width: sizeH * 100,
      height: sizeV * 7,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        foodViewModel.stringSearch = query;
      },
      onSubmitted: (query) {
        if (!foodViewModel.listNutritionHistoryLocal.contains(query)) {
          foodViewModel.updateNutritionHistoryList(
              FirebaseAuth.instance.currentUser!.uid, query);
          foodViewModel
              .getNutritionHistoryList(FirebaseAuth.instance.currentUser!.uid);
        }

        get(foodViewModel, query, context);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: whiteColor,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  Provider.of<FoodViewModel>(context).runFilter().map((e) {
                return GestureDetector(
                  // focusColor: Colors.amber,
                  // highlightColor: greenLightProfile,
                  onTap: () {
                    get(foodViewModel, e, context);
                  },
                  // hoverColor: greenLightProfile,
                  // overlayColor:
                  //     MaterialStateProperty.all<Color>(greenLightProfile),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.blockSizeH! * 2,
                      ),
                      Icon(
                        Icons.access_time,
                        size: SizeConfig.blockSizeH! * 6,
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: SizeConfig.blockSizeH! * 5),
                        height: 50,
                        child: Center(
                          child: Text(
                            e,
                            style: foodSearchText,
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
      backdropColor: Colors.transparent,
    );
  }

  void get(
      FoodViewModel foodViewModel, String string, BuildContext context) async {
    EasyLoading.showInfo('Loading...');
    final list = await foodViewModel.getFoodNutrition(string);

    if (list.isNotEmpty) {
      EasyLoading.dismiss();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FoodNutritionDiaLog(
            title: list[0].name,
            calories: list[0].calories,
            servingSizeG: list[0].servingSizeG,
            fatTotalG: list[0].fatTotalG,
            fatSaturatedG: list[0].fatSaturatedG,
            proteinG: list[0].proteinG,
            sodiumMg: list[0].sodiumMg,
            potassiumMg: list[0].potassiumMg,
            cholesterolMg: list[0].cholesterolMg,
            carbohydratesTotalG: list[0].carbohydratesTotalG,
            fiberG: list[0].fiberG,
            sugarG: list[0].sugarG,
          );
        },
      );
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return FoodNoResult();
          });
    }
  }
}
