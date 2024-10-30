import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/model/scan_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin EmpMix {
  // try {
  //     final res = await SuperMain()
  //         .supabase
  //         .from("order")
  //         .select()
  //         .eq("child_id", childModel.id)
  //

  //     return res;
  //   } catch (er) {
  //     log("$er");

  //     rethrow;
  //   }

  Future<double> bringPreOrderLimt({required ChildModel childModel}) async {
    try {
      double totalPreLimt = 0;
      final date = DateTime.now().toIso8601String().split('T')[0];
      final res = await SuperMain()
          .supabase
          .from("orders")
          .select()
          .eq("child_id", childModel.id)
          .eq("status", "open_day")
          .eq("create_date", date);

      for (var val in res) {
        totalPreLimt += val["total_price"];
      }

      return totalPreLimt;
    } catch (er) {
      log("$er");
      rethrow;
    }
  }

  checkOutOrder({
    required PlanModel? planModel,
    required OrderModel? selctFoodOrder,
    required List<OrderModel> orderLis,
    required ChildModel childModel,
    required double dailyLimitTotal,
  }) async {
    final date = DateTime.now().toIso8601String().split('T')[0];

    try {
      if (planModel != null) {
        await SuperMain().supabase.rpc('append_date_to_meal_plan', params: {
          'meal_plan_id': planModel.id,
          'new_date': date,
        });
      }

      if (selctFoodOrder != null) {
        log(" in mix check  len of open_day  ${selctFoodOrder.orderItemModelLis.length}");
        final orderRes = await SuperMain().supabase.from("orders").insert({
          "child_id": childModel.id,
          "status": "open_day",
          "total_price": dailyLimitTotal,
          "create_date": date
        }).select();

        for (var orderItem in selctFoodOrder.orderItemModelLis) {
          await SuperMain().supabase.from("order_item").insert({
            "order_id": orderRes[0]["id"],
            "quantity": orderItem.quantity,
            "menu_id": orderItem.menuId
          }).select();
        }
      }

      if (orderLis.isNotEmpty) {
        for (var order in orderLis) {
          await SuperMain()
              .supabase
              .from("orders")
              .update({"status": "completed"})
              .eq("id", order.id)
              .select();
        }
      }

      await SuperMain()
          .supabase
          .from("followers")
          .update({"funds": childModel.funds - dailyLimitTotal}).eq(
              "id", childModel.id);
    } catch (er) {
      log("$er");
    }
  }

  Future<PlanModel?> getChildPlan({required ChildModel childModel}) async {
    // try {
    // List<PlanModel> planModelLis = [];
    PlanModel? plan;
    final date = DateTime.now().toIso8601String().split('T')[0];
    // log(date);

    final res = await SuperMain()
        .supabase
        .from("meal_plans")
        .select()
        .eq("child_id", childModel.id)
        .lte("start_date", date)
        .gte("end_date", date);

    log("$res");

// first check if the child take the food in the same day or not
    List<String> dateTakenTempList = List<String>.from(res[0]["dates_taken"]);

    if (dateTakenTempList.contains(date)) {
      return null;
    }
    for (var val in res) {
      log("in plan for");
      plan = PlanModel.fromJson(val);

      final mealItem = await SuperMain()
          .supabase
          .from("meal_plan_items")
          .select()
          .eq("meal_plan_id", plan.id);

      log("how many meal item ::: ${mealItem.length}");

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

      // planModelLis.add(plan);
      // planModelLis.length;

      // log("${planModelLis.length}");
    }

    // log("$res");

    return plan;
    // } catch (er) {
    //   log("$er");

    //   rethrow;
    // }
  }

  orderInfo({required OrderModel orderModel}) async {
    // try {
    final res = await SuperMain()
        .supabase
        .from("order_item")
        .select()
        .eq("order_id", orderModel.id);

    for (var val in res) {
      orderModel.orderItemModelLis.add(OrderItemModel.fromJson(val));
    }

    for (var val in orderModel.orderItemModelLis) {
      final food = await SuperMain()
          .supabase
          .from("food_menu")
          .select()
          .eq("id", val.menuId);

      val.foodMenuModel = FoodMenuModel.fromJson(food[0]);
      print(val.foodMenuModel?.foodName);
    }
    // } catch (er) {
    //   log("$er");

    //   rethrow;
    // }
  }

  Future<List<Map<String, dynamic>>> getChildOrder(
      {required ChildModel childModel}) async {
    // try {
    final res = await SuperMain()
        .supabase
        .from("orders")
        .select()
        .eq("child_id", childModel.id)
        .eq("status", "active");

    return res;
    // } catch (er) {
    //   log("$er");

    //   rethrow;
    // }
  }

  getEmpSchool() async {
    try {
      AppModel appModel = getIt.get<AppModel>();

      final schollRes = await SuperMain()
          .supabase
          .from("school")
          .select()
          .eq("id", appModel.empModel!.schoolId);

      appModel.empModel!.schoolModel = SchoolModel.fromJson(schollRes[0]);

      final foodRes = await SuperMain()
          .supabase
          .from("food_menu")
          .select()
          .eq("school_id", appModel.empModel!.schoolModel.id);

      for (var val in foodRes) {
        appModel.empModel!.schoolModel.foodMenuModelList
            .add(FoodMenuModel.fromJson(val));
      }
    } catch (er) {
      log("$er");
    }
  }
}
