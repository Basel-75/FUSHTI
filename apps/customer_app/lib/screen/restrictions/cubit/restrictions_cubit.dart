import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
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
    for (var element in restrictionsFood) {
      log('${element.toJson()}');
    }
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
        }
      }
    } catch (e) {
      log('$e');
    }
  }

  deleteRestrictionFood({required String productId}) async {
    try {
      emit(LoadingState());
      //Delete in DB
      await SuperMain().deleteRestrictionFood(productId: productId);
      //Delete Locale
      restrictionsFood.removeWhere(
        (element) => element.menuItemId == productId,
      );
      emit(
          SuccessDeleteState(msg: 'تم ازالة الوجبة من الوجبات المحظورة بنجاح'));
    } catch (e) {
      log('$e');
      emit(ErrorState(msg: 'حدث خطأ ما يرجى اعادة المحاولة لاحقا'));
    }
  }

  @override
  Future<void> close() {
    // restrictionsFood.clear();
    return super.close();
  }
}
