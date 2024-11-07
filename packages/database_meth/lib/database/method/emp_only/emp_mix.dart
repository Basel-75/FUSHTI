import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin EmpMix {
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
    } catch (er) {}
  }

  Future<PlanModel?> getChildPlan({required ChildModel childModel}) async {
    PlanModel? plan;
    final date = DateTime.now().toIso8601String().split('T')[0];

    final res = await SuperMain()
        .supabase
        .from("meal_plans")
        .select()
        .eq("child_id", childModel.id)
        .lte("start_date", date)
        .gte("end_date", date);

// first check if the child take the food in the same day or not
    List<String> dateTakenTempList = List<String>.from(res[0]["dates_taken"]);

    if (dateTakenTempList.contains(date)) {
      return null;
    }
    for (var val in res) {
      plan = PlanModel.fromJson(val);

      final mealItem = await SuperMain()
          .supabase
          .from("meal_plan_items")
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
    }

    return plan;
  }

  orderInfo({required OrderModel orderModel}) async {
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
      print(val.foodMenuModel.foodName);
    }
  }

  Future<List<Map<String, dynamic>>> getChildOrder(
      {required ChildModel childModel}) async {
    final res = await SuperMain()
        .supabase
        .from("orders")
        .select()
        .eq("child_id", childModel.id)
        .eq("status", "active");

    return res;
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
    } catch (er) {}
  }

  editProduct({required FoodMenuModel product}) async {
    try {
      final response = await SuperMain()
          .supabase
          .from('food_menu')
          .update({
            'school_id': product.schoolId,
            'food_name': product.foodName,
            'description': product.description,
            'price': product.price,
            'category': product.category,
            'available': product.available,
            'cal': product.cal,
            'allergy': product.allergy,
            'image_url': product.imageUrl,
          })
          .eq('id', product.id)
          .select();
    } catch (e) {}
  }

  addProduct({required FoodMenuModel product}) async {
    try {
      final response = await SuperMain().supabase.from('food_menu').insert({
        'school_id': product.schoolId,
        'food_name': product.foodName,
        'description': product.description,
        'price': product.price,
        'category': product.category,
        'available': product.available,
        'cal': product.cal,
        'allergy': product.allergy,
        'image_url': product.imageUrl,
      }).select();

      if (response.isNotEmpty) {
        return response[0]; // Return the first item if response is a list
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  deleteProduct({required String productId}) async {
    try {
      await SuperMain().supabase.from('food_menu').delete().eq('id', productId);
    } catch (e) {}
  }

  getAllOrders() async {
    try {
      final response = await SuperMain().supabase.from('orders').select('*');

      return response;
    } catch (e) {
      throw Exception("خطأ في استرجاع عدد الطلبات.");
    }
  }

  getTotalSalesCount() async {
    try {
      final response = await SuperMain()
          .supabase
          .from('orders')
          .select('id')
          .eq('status', 'completed')
          .select();
      return response;
    } catch (e) {
      throw Exception("خطأ في استرجاع عدد المبيعات.");
    }
  }
}
