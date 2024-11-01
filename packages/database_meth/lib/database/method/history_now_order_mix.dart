import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';

import 'package:get_all_pkg/data/model/history_order_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin HistoryNowOrderMix {
  Future<List<PlanModel>> bringPlan({required ChildModel childModel}) async {
    try {
      AppModel appModel = getIt.get<AppModel>();
      final todayDate =
          DateTime.now().toUtc().toIso8601String().split('T').first;

      final List<PlanModel> lis = [];

      // final res = await SuperMain()
      //     .supabase
      //     .from("meal_plans")
      //     .select()
      //     .eq("child_id", childModel.id)
      //     .gte("end_date", todayDate)
      // .not("dates_taken", "eq", {todayDate});
      // print(res);

      final res = await SuperMain().supabase.rpc("get_active_meal_plans",params: {

        "p_child_id" : childModel.id,
        "p_today" : todayDate
      });

      for (var plan in res) {
        final tempPlan = PlanModel.fromJson(plan);

        final itemRes = await SuperMain()
            .supabase
            .from("meal_plan_items")
            .select()
            .eq("meal_plan_id", tempPlan.id);

        for (var item in itemRes) {
          final tempItem = MealPlanItemModel.fromJson(item);

          final food = await SuperMain()
              .supabase
              .from("food_menu")
              .select()
              .eq("id", tempItem.menuItemId);

          tempItem.foodMenuModel = FoodMenuModel.fromJson(food[0]);

          tempPlan.mealPlanItemLis.add(tempItem);
        }

        lis.add(tempPlan);
      }

      return lis;
    } catch (er) {
      log("$er");
      rethrow;
    }
  }

  Future<List<OrderModel>> bringOrder({required ChildModel childModel}) async {
    try {
      AppModel appModel = getIt.get<AppModel>();

      final List<OrderModel> lis = [];

      final orderRes = await SuperMain()
          .supabase
          .from("orders")
          .select()
          .neq("status", "completed")
          .eq("child_id", childModel.id);

      for (var order in orderRes) {
        final tempOrder = OrderModel.fromJson(order);

        final itemOrder =
            await SuperMain().supabase.from("order_item").select();

        // final List<OrderItemModel>  tempItemLis = [];
        for (var item in itemOrder) {
          final tempItem = OrderItemModel.fromJson(item);

          final food = await SuperMain()
              .supabase
              .from("food_menu")
              .select()
              .eq("id", tempItem.menuId);

          tempItem.foodMenuModel = FoodMenuModel.fromJson(food[0]);
          tempOrder.orderItemModelLis.add(tempItem);
        }

        lis.add(tempOrder);
      }

      return lis;
    } catch (er) {
      log("$er");
      rethrow;
    }
  }

  Future<List<HistoryOrderModel>> orderHistory() async {
    try {
      AppModel appModel = getIt.get<AppModel>();

      final List<HistoryOrderModel> lis = [];

      final res = await SuperMain()
          .supabase
          .from("history")
          .select()
          .eq("user_id", appModel.userModel!.id)
          .order("action_time");

      for (var val in res) {
        //  ----------------------------- for order handle if the history is order -------------------------------
        if (val["source"] == "order") {
          final orderRes = await SuperMain()
              .supabase
              .rpc("get_child_orders_by_user", params: {
            "p_child_id": val["child_id"],
            "p_order_id": val["record_id"]
          });

          final childTemp = ChildModel.fromJson(orderRes["child"]);

          final orederTemp = OrderModel.fromJson(orderRes["orders"][0]);

          List<OrderItemModel> orderItemLis = [];

          for (var val in orderRes["orders"][0]["order_items"]) {
            final orderItemTemp = OrderItemModel.fromJson(val);

            orderItemTemp.foodMenuModel =
                FoodMenuModel.fromJson(val["food_menu"]);

            orderItemLis.add(orderItemTemp);
          }
          orederTemp.orderItemModelLis.addAll(orderItemLis);
          orederTemp.childModel = childTemp;

          lis.add(
              HistoryOrderModel(childModel: childTemp, orderModel: orederTemp));
        }
        //  ----------------------------- for order handle if the history is plan -------------------------------
        else {
          final planRes = await SuperMain().supabase.rpc("get_child_meal_plans",
              params: {
                "p_child_id": val["child_id"],
                "p_meal_plan_id": val["record_id"]
              });

          final planTemp = PlanModel.fromJson(planRes["meal_plans"][0]);
          final tempChild = ChildModel.fromJson(planRes["child"]);

          final List<MealPlanItemModel> tmeMealLis = [];

          for (var val in planRes["meal_plans"][0]["meal_plan_items"]) {
            final meal = MealPlanItemModel.fromJson(val);
            final food = FoodMenuModel.fromJson(val["food_menu"]);

            meal.foodMenuModel = food;

            tmeMealLis.add(meal);
          }

          planTemp.mealPlanItemLis.addAll(tmeMealLis);
          planTemp.childModel = tempChild;

          lis.add(
              HistoryOrderModel(childModel: tempChild, planModel: planTemp));
        }
      }

      return lis;
    } catch (er) {
      log("$er");

      rethrow;
    }
  }
}
