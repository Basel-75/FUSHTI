import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/screen/product/cubit/product_cubit.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/helper/check_intent.dart';
import 'package:meta/meta.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());

  AppModel appModel = getIt.get<AppModel>();

  List<PlanModel> planListUi = [];

  List<MealPlanItemModel> mealPlanItemLisUi = [];

  clickInChild({required ChildModel childModel}) {
    mealPlanItemLisUi.clear();
    planListUi = childModel.planList;

    emit(ChildClickState());
  }

  clickPlanState({required PlanModel planModel}) {
    mealPlanItemLisUi.clear();
    log("${planModel.name}");
    log("${mealPlanItemLisUi.length}");
    // mealPlanItemLisUi. = planModel.mealPlanItemLis;
    mealPlanItemLisUi.addAll(planModel.mealPlanItemLis);

    log("after");
    log("${mealPlanItemLisUi.length}");

    emit(PlanClickState());
  }

  delPlanItem({required MealPlanItemModel mealPlanItemModel}) async {
    log("in del method");

    final inter = await CheckIntent().checkInternetConnection();

    if (inter) {
      log("there is inter");
    } else {
        log("there is no  inter");
    }
    for (int i = 0; i < mealPlanItemLisUi.length; i++) {
      if (mealPlanItemLisUi[i].id == mealPlanItemModel.id) {
        mealPlanItemLisUi.removeAt(i);
        emit(DelItemState());
        return;
      }
    }
  }
}
