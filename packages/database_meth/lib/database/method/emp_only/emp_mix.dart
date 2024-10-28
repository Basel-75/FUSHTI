import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
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

  Future<List<Map<String, dynamic>>> getChildPlan(
      {required ChildModel childModel}) async {
    try {
      final res = await SuperMain()
          .supabase
          .from("meal_plans")
          .select()
          .eq("child_id", childModel.id)
          .eq("status", "active");

      return res;
    } catch (er) {
      log("$er");

      rethrow;
    }
  }

  orderInfo({required OrderModel orderModel}) async {
    try {
      final res = await SuperMain()
          .supabase
          .from("order")
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
      }
    } catch (er) {
      log("$er");

      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getChildOrder(
      {required ChildModel childModel}) async {
    try {
      final res = await SuperMain()
          .supabase
          .from("order")
          .select()
          .eq("child_id", childModel.id)
          .eq("status", "active");

      return res;
    } catch (er) {
      log("$er");

      rethrow;
    }
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

  deleteProduct({required String productId}) async {
    try {
      await SuperMain().supabase.from('food_menu').delete().eq('id', productId);
    } catch (e) {
      log('$e');
    }
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

      log('$response');
    } catch (e) {
      log('$e');
    }
  }

  editProduct({required FoodMenuModel product}) async {
    log('${product.toJson()}');
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

      log('$response');
    } catch (e) {
      log('$e');
    }
  }
}
