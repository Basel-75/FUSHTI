import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/history_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin HistoryMix {
  // getPlanByID({required String planId}) async {
  //   try {

  //     SuperMain().supabase.from(table)

  //   } catch (er) {
  //     log("$er");
  //     rethrow;
  //   }
  // }

  // getOrderById({required String orderId}) async {
  //   try {

  //   } catch (er) {
  //     log("$er");
  //     rethrow;
  //   }
  // }

  Future<List<HistoryModel>> orderHistory() async {
    try {
    AppModel appModel = getIt.get<AppModel>();
    

    final List<HistoryModel> lis = [];

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

        lis.add(HistoryModel(childModel: childTemp, orderModel: orederTemp));
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

        lis.add(HistoryModel(childModel: tempChild, planModel: planTemp));
      }
    }

    return lis;
    } catch (er) {
      log("$er");

      rethrow;
    }
  }
}
