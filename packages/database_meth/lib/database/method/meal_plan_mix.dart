import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin MealPlanMix {
  editPlan({required PlanModel plan, required String name}) async {
    try {
      await SuperMain()
          .supabase
          .from("meal_plan_templates")
          .update({"name": name}).eq("id", plan.id);
    } catch (er) {}
  }

  delPlan({required PlanModel plan}) async {
    try {
      await SuperMain()
          .supabase
          .from("meal_plan_templates")
          .delete()
          .eq("id", plan.id);
    } catch (er) {}
  }

  payForPlan(
      {required PlanModel planModel,
      required DateTime stratDate,
      required DateTime endDate,
      required double totalPrice}) async {
    try {
      AppModel appModel = getIt.get<AppModel>();
      await SuperMain().supabase.rpc("decrement_funds",
          params: {"user_id": appModel.userModel!.id, "amount": totalPrice});

      appModel.userModel!.funds -= totalPrice;

      int totalMeals = 0;
      for (var val in planModel.mealPlanItemLis) {
        totalMeals += val.quantity;
      }
      final planRes = await SuperMain().supabase.from("meal_plans").insert({
        "child_id": planModel.childId,
        "start_date": stratDate.toIso8601String(),
        "end_date": endDate.toIso8601String(),
        "total_meals": totalMeals,
        "status": "active",
        "total_price": totalPrice
      }).select();

      for (var val in planModel.mealPlanItemLis) {
        final mealRes =
            await SuperMain().supabase.from("meal_plan_items").insert({
          "meal_plan_id": planRes[0]["id"],
          "menu_item_id": val.menuItemId,
          "quantity": val.quantity
        }).select();
      }
    } catch (er) {}
  }

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
    } catch (er) {
      rethrow;
    }
  }

  delMealItem({required String id}) async {
    try {
      await SuperMain().supabase.rpc("del_mel_item", params: {"row_id": id});
    } catch (er) {}
  }

  Future<Map<String, dynamic>> addPlan({
    required String childId,
    required String name,
  }) async {
    try {
      final res =
          await SuperMain().supabase.from("meal_plan_templates").insert({
        "child_id": childId,
        "name": name,
        "start_date": DateTime.now().toIso8601String(),
        "end_date": DateTime.now().toIso8601String(),
        "total_meals": 0
      }).select();

      return res[0];
    } catch (er) {
      throw "";
    }
  }

  addPlanItem(
      {required String name,
      required ChildModel childModel,
      required FoodMenuModel foodMenuModel}) async {
    try {
      late PlanModel plan;
      for (var val in childModel.planList) {
        if (val.name == name) {
          plan = val;

          for (var item in plan.mealPlanItemLis) {
            if (foodMenuModel.id == item.menuItemId) {
              throw "This item in your cart";
            }
          }

          break;
        }
      }

      final res = await SuperMain()
          .supabase
          .from("meal_plan_template_items")
          .insert({
        "meal_plan_id": plan.id,
        "menu_item_id": foodMenuModel.id,
        "quantity": 1
      }).select();

      MealPlanItemModel temp = MealPlanItemModel.fromJson(res[0]);

      temp.foodMenuModel = foodMenuModel;

      plan.mealPlanItemLis.add(temp);
    } catch (er) {
      rethrow;
    }
  }
}
