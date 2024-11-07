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

  ChildModel? childModelSelected;

  PlanModel? planModelSelected;

  clickInChild({required ChildModel childModel}) {
    planModelSelected = null;
    mealPlanItemLisUi.clear();
    planListUi = childModel.planList;

    childModelSelected = childModel;

    emit(ChildClickState());
  }

  delPlan() async {
    try {
      emit(LoadingState());
      if (planModelSelected == null) {
        return;
      }

      final inter = await CheckIntent().checkInternetConnection();

      if (inter) {
        SuperMain().delPlan(plan: planModelSelected!);

        childModelSelected!.planList.removeWhere(
          (element) {
            return element.name == planModelSelected!.name;
          },
        );
        planModelSelected = null;
        emit(PlanChangeState(msg: "تم حذف الخطة بنجاح"));
      } else {
        emit(NoInterState());
      }
    } catch (er) {}
  }

  editPlan() async {
    try {
      if (planModelSelected == null) {
        return;
      }

      final inter = await CheckIntent().checkInternetConnection();

      if (inter) {
        if (planNameCOn.text.isEmpty) {
          emit(ErrorPlanState(msg: "اضف اسم للخطة"));

          return;
        }

        for (var val in planListUi) {
          if (val.name! == planNameCOn.text) {
            emit(ErrorPlanState(msg: "هناك خطة بنفس الاسم"));
            return;
          }
        }

        emit(LoadingState());

        SuperMain().editPlan(plan: planModelSelected!, name: planNameCOn.text);

        planModelSelected!.name = planNameCOn.text;

        emit(NoLoadingState());
        emit(PlanChangeState(msg: "تم تعديل الخطة"));
      } else {
        emit(NoInterState());
      }
    } catch (er) {}
  }

  clickPlanState({required PlanModel planModel}) {
    mealPlanItemLisUi.clear();

    planModelSelected = planModel;
    mealPlanItemLisUi.addAll(planModel.mealPlanItemLis);

    emit(PlanClickState());
  }

  delPlanItem({required MealPlanItemModel mealPlanItemModel}) async {
    final inter = await CheckIntent().checkInternetConnection();

    if (inter) {
      SuperMain().delMealItem(id: mealPlanItemModel.id);

      for (int i = 0; i < mealPlanItemLisUi.length; i++) {
        if (mealPlanItemLisUi[i].id == mealPlanItemModel.id) {
          mealPlanItemLisUi.removeAt(i);
          planModelSelected!.mealPlanItemLis.removeAt(i);
          emit(DelItemState());
          return;
        }
      }
    } else {
      emit(NoInterState());
    }
  }

  addPlan() async {
    // check if there is plan with same name

    if (planNameCOn.text.isEmpty) {
      emit(ErrorPlanState(msg: "اضف اسم للخطة"));

      return;
    }

    for (var val in planListUi) {
      if (val.name! == planNameCOn.text) {
        emit(ErrorPlanState(msg: "هناك خطة بنفس الاسم"));
        return;
      }
    }

    try {
      emit(LoadingState());
      final res = await SuperMain()
          .addPlan(childId: childModelSelected!.id, name: planNameCOn.text);

      childModelSelected!.planList.add(PlanModel.fromJson(res));

      emit(NoLoadingState());
      emit(PlanChangeState(msg: "تم اضافة الخطة بنجاح"));
    } catch (er) {
      emit(NoLoadingState());
      emit(ErrorPlanState(msg: "حصل خطأ ما يرجى المحاولة لاحقا"));
    }
  }

// check before add plan if there is child or not
  bool isThereChild() {
    if (childModelSelected == null) {
      emit(ErrorPlanState(msg: "اختر التابع اولا"));
      return false;
    } else {
      return true;
    }
  }

  toCart() {
    if (planModelSelected == null) {
      emit(ErrorPlanState(msg: "يرجى اختيار خطة"));
      return;
    } else if (planModelSelected!.mealPlanItemLis.isEmpty) {
      emit(ErrorPlanState(msg: "خطتك فارغة"));
      return;
    }

    emit(ToCartState());
  }
}
