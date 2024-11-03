import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/helper/check_intent.dart';

part 'plan_state.dart';

class PlanCubit extends Cubit<PlanState> {
  PlanCubit() : super(PlanInitial());

  AppModel appModel = getIt.get<AppModel>();

  List<PlanModel> planListUi = [];

  List<MealPlanItemModel> mealPlanItemLisUi = [];

  TextEditingController planNameCOn = TextEditingController();

  ChildModel? childModelSelcted;

  PlanModel? planModelSelcted;

  clickInChild({required ChildModel childModel}) {
    planModelSelcted = null;
    mealPlanItemLisUi.clear();
    planListUi = childModel.planList;

    childModelSelcted = childModel;

    emit(ChildClickState());
  }

  delPlan() async {
    try {
      emit(LodingState());
      if (planModelSelcted == null) {
        // emit(ErorrState(msg: msg));
        return;
      }

      final inter = await CheckIntent().checkInternetConnection();

      if (inter) {
        log("there is inter");
        SuperMain().delPlan(plan: planModelSelcted!);

        childModelSelcted!.planList.removeWhere(
          (element) {
            return element.name == planModelSelcted!.name;
          },
        );
        planModelSelcted = null;
        emit(PlanChnageState(msg: "تمت حذف خطة"));
      } else {
        log("there is no  inter");
        emit(NoInterState());
      }
    } catch (er) {
      log("$er");
    }
  }

  editPlan() async {
    try {
      if (planModelSelcted == null) {
        // emit(ErorrState(msg: msg));
        return;
      }

      final inter = await CheckIntent().checkInternetConnection();

      if (inter) {
        log("there is inter");

        if (planNameCOn.text.isEmpty) {
          emit(EorrPlanState(msg: "اضف اسم للخطة"));

          return;
        }

        for (var val in planListUi) {
          if (val.name! == planNameCOn.text) {
            emit(EorrPlanState(msg: "هناك خطة بنفس الاسم"));
            return;
          }
        }

        emit(LodingState());

        SuperMain().editPlan(plan: planModelSelcted!, name: planNameCOn.text);

        planModelSelcted!.name = planNameCOn.text;

        emit(NoLodingState());
        emit(PlanChnageState(msg: "تمت تعديل خطة"));
      } else {
        log("there is no  inter");
        emit(NoInterState());
      }
    } catch (er) {
      log("$er");
    }
  }

  clickPlanState({required PlanModel planModel}) {
    mealPlanItemLisUi.clear();
    log("${planModel.name}");
    log("${mealPlanItemLisUi.length}");

    planModelSelcted = planModel;
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
      SuperMain().delMealItem(id: mealPlanItemModel.id);

      for (int i = 0; i < mealPlanItemLisUi.length; i++) {
        if (mealPlanItemLisUi[i].id == mealPlanItemModel.id) {
          mealPlanItemLisUi.removeAt(i);
          planModelSelcted!.mealPlanItemLis.removeAt(i);
          emit(DelItemState());
          return;
        }
      }
    } else {
      log("there is no  inter");
      emit(NoInterState());
    }
  }

  addPlan() async {
    log("in add plan");

    // check if there is plan with same name

    if (planNameCOn.text.isEmpty) {
      emit(EorrPlanState(msg: "اضف اسم للخطة"));

      return;
    }

    for (var val in planListUi) {
      if (val.name! == planNameCOn.text) {
        emit(EorrPlanState(msg: "هناك خطة بنفس الاسم"));
        return;
      }
    }

    try {
      emit(LodingState());
      final res = await SuperMain()
          .addPlan(childId: childModelSelcted!.id, name: planNameCOn.text);

      childModelSelcted!.planList.add(PlanModel.fromJson(res));

      emit(NoLodingState());
      emit(PlanChnageState(msg: "تمت اضافة خطة"));

      log("plan has been add");
    } catch (er) {
      emit(NoLodingState());
      emit(EorrPlanState(msg: "there was eorr"));
    }
  }

// check before add plan if there is child or not
  bool isThereChild() {
    if (childModelSelcted == null) {
      emit(EorrPlanState(msg: "chose child first"));
      return false;
    } else {
      return true;
    }
  }

  toCart() {
    if (planModelSelcted == null) {
      emit(EorrPlanState(msg: "chose plan"));
      return;
    } else if (planModelSelcted!.mealPlanItemLis.isEmpty) {
      emit(EorrPlanState(msg: "your plan is emty"));
      return;
    }

    emit(ToCartState());
  }
}
