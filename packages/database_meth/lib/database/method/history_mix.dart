import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/history_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
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
    // try {
    AppModel appModel = getIt.get<AppModel>();
    log("in orderHis mix");

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
        log("before");
        log("${val["child_id"]}");
        final orderRes = await SuperMain()
            .supabase
            .rpc("get_child_orders_by_user", params: {
          "p_child_id": val["child_id"],
          "p_order_id": val["record_id"]
        });
        log("here");

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

        lis.add(HistoryModel(childModel: childTemp, orderModel: orederTemp));
      }
    }

    return lis;
    // } catch (er) {
    //   log("$er");

    //   rethrow;
    // }
  }
}
