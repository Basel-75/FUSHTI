import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/restriction_food_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  AppModel appModel = getIt.get<AppModel>();

  List<ChildModel> childModelList = [];

  late ChildModel currentChild;

  initHome() {
    childModelList = appModel.userModel!.childModelList;

    log("there is ${childModelList.length}");

    currentChild = childModelList.first;
  }

  chnageChild(ChildModel child) {
    if (child != currentChild) {
      log("in if change child");
      currentChild = child;
      emit(ChnageChildState());
    }
  }

  addToRestrictionsFood(
      {required String childId, required String productId}) async {
    //update in DB
    await SuperMain()
        .supabase
        .from('food_restriction')
        .insert({'child_id': childId, 'menu_item_id': productId});
    //update locale
    for (var element in appModel.userModel!.childModelList) {
      if (element.id == childId) {
        element.restrictionFood
            .add(RestrictionFoodModel(childId: childId, menuItemId: productId));
      }
    }
  }
}
