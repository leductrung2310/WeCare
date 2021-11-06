import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/constants.dart';
import 'package:wecare_flutter/model/food.dart';
import 'package:wecare_flutter/screen/food/widgets/food_nutrition_dialog.dart';
import 'package:wecare_flutter/view_model/food_view_model.dart';
import 'package:http/http.dart' as http;

class SearchBarCustom extends StatelessWidget {
  const SearchBarCustom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    final foodViewModel = Provider.of<FoodViewModel>(context, listen: false);

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
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      height: 55,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        foodViewModel.stringSearch = query;
      },
      onSubmitted: (query) {
        if (!foodViewModel.listFoodSearchHistory.contains(query)) {
          foodViewModel.listFoodSearchHistory.add(query);
        }

        get(foodViewModel, query, context);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        // FloatingSearchBarAction(
        //   showIfOpened: false,
        //   child: CircularButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {},
        //   ),
        // ),
        FloatingSearchBarAction.searchToClear(),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: whiteColor,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Provider.of<FoodViewModel>(context)
                  .searchFood(foodViewModel.stringSearch)
                  .map((e) {
                return InkWell(
                  focusColor: Colors.amber,
                  highlightColor: greenLightProfile,
                  onTap: () {
                    get(foodViewModel, e, context);
                  },
                  hoverColor: greenLightProfile,
                  overlayColor:
                      MaterialStateProperty.all<Color>(greenLightProfile),
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
                      InkWell(
                        child: Icon(
                          Icons.clear,
                          size: SizeConfig.blockSizeH! * 6,
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeH! * 2,
                      ),
                    ],
                  ),
                );
              }).toList(),
              // children: Colors.accents.map((color) {
              //   return Container(height: 50, color: color);
              // }).toList(),
            ),
          ),
        );
      },
      backdropColor: Colors.transparent,
    );
  }

  void get(
      FoodViewModel foodViewModel, String string, BuildContext context) async {
    final list = await foodViewModel.getFoodNutrition(string);

    if (list.isNotEmpty) {
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
    } else
      print("2");
  }
}
