import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/restriction_food_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'restrictions_state.dart';

class RestrictionsCubit extends Cubit<RestrictionsState> {
  AppModel appModel = getIt.get<AppModel>();
  List<RestrictionFoodModel> restrictionsFood = [];
  List<FoodMenuModel> foodMenuModelList = [];
  RestrictionsCubit() : super(RestrictionsInitial());

  getRestrictionFoodList({required String childId}) {
    restrictionsFood.forEach((element) => log('${element.toJson()}'),);
    try {
      for (var element in appModel.userModel!.childModelList) {
        if (element.id == childId) {
          restrictionsFood = element.restrictionFood;
          for (var food in restrictionsFood) {
            foodMenuModelList
                .addAll(element.schoolModel.foodMenuModelList.where(
              (element) => element.id == food.menuItemId,
            ));
          }
          foodMenuModelList = element.schoolModel.foodMenuModelList;
        }
      }
    } catch (e) {
      log('$e');
    }
  }
  @override
  Future<void> close() {
    // restrictionsFood.clear();
    return super.close();
  }
}
