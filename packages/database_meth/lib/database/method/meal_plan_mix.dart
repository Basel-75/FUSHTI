import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin MealPlanMix {
  getChildernPlan() async {
    try {
      AppModel appModel = getIt.get<AppModel>();

      for (var child in appModel.userModel!.childModelList) {
        final plan = await SuperMain()
            .supabase
            .from("meal_plan_templates")
            .select()
            .eq("child_id", child.id);

        // meal_plan_templates ready is model
        for (var planItem in plan) {
          PlanModel plan = PlanModel.fromJson(planItem);

          final mealItem = await SuperMain()
              .supabase
              .from("meal_plan_template_items")
              .select()
              .eq("meal_plan_id", plan.id);

          //  meal item model ready
          for (var mealItemIndex in mealItem) {
            final MealPlanItemModel mealPlanItemModel =
                MealPlanItemModel.fromJson(mealItemIndex);

            final res = await SuperMain()
                .supabase
                .from("food_menu")
                .select()
                .eq("id", mealPlanItemModel.menuItemId);

            mealPlanItemModel.foodMenuModel = FoodMenuModel.fromJson(res[0]);

            plan.mealPlanItemLis.add(mealPlanItemModel);
          }

          child.planList.add(plan);
        }
      }

      log("${appModel.userModel!.childModelList[0].planList.length}");
      log("${appModel.userModel!.childModelList[0].planList[0].toJson()}");
      log("${appModel.userModel!.childModelList[0].planList[0].mealPlanItemLis.length}");
      log("${appModel.userModel!.childModelList[0].planList[0].mealPlanItemLis[0].toJson()}");
      log("${appModel.userModel!.childModelList[0].planList[0].mealPlanItemLis[0].foodMenuModel.toJson()}");
    } catch (er) {
      log("$er");
    }
  }

  delMealItem({required String id}) async {
    try {
      await SuperMain().supabase.rpc("del_mel_item", params: {"row_id": id});
      log("very good del");
    } catch (er) {
      log("$er");
    }
  }

  Future<Map<String, dynamic>> addPlan({
    required String childId,
    required String name,
  }) async {
    try {
      final response = await SuperMain().supabase.rpc(
        'add_meal_plan_template',
        params: {
          '_child_id': childId,
          '_name': name,
          '_start_date': DateTime.now(),
          '_end_date': DateTime.now(),
          '_total_meals': 0,
        },
      );

      return response;
    } catch (er) {
      log("$er");

      throw "";
    }
  }
}
