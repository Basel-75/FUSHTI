import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  late ChildModel childModel;

  List<OrderModel> orderLis = [];

  List<PlanModel> planModelLis = [];

  getAllCHildOrder() async {
    try {
      final res = await SuperMain().getChildOrder(childModel: childModel);

//  first order model
      for (var val in res) {
        orderLis.add(OrderModel.fromJson(val));
      }

// then orderItem

      for (var val in orderLis) {
        await SuperMain().orderInfo(orderModel: val);
      }

      planModelLis = await SuperMain().getChildPlan(childModel: childModel);

      // log("${planModelLis[0].status}");
    } catch (er) {
      log("$er");
      rethrow;
    }

    log("here in show up");

    // log("${planModelLis[0].toJson()}");
    // log(" the lenth  ${planModelLis[0].mealPlanItemLis.length}");
    // log("${planModelLis[0].mealPlanItemLis[0].toJson()}");
    // log("${planModelLis[0].mealPlanItemLis[0].foodMenuModel.toJson()}");

    // log(" order lenth${orderLis.length}");
    // log(" order item lenth  ${orderLis[0].orderItemModelLis.length}");
    // log(" order item lenth  ${orderLis[0].orderItemModelLis[0].toJson()}");
    // log(" order item lenth  ${orderLis[0].orderItemModelLis[0].foodMenuModel.toJson()}");

    // //  for print

    // log("plan print");

    // for (var val in planModelLis) {
    //   log("in plan print");

    //   log("${val.toJson()}");
    //   print(val.toJson());

    //   log("----------------------------------------");

    //   for (var mealPlan in val.mealPlanItemLis) {
    //     log("${mealPlan.toJson()}");
    //     log("----------------------------------------");

    //     log("${mealPlan.foodMenuModel.toJson()}");
    //   }

    //   log("#################################");
    // }

    // // for order print

    // log("order print");

    // for (var val in orderLis) {
    //   log("${val.toJson()}");
    //   log("---------------------------------------------------");

    //   for (var orderItem in val.orderItemModelLis) {
    //     log("${orderItem.toJson()}");
    //     log("---------------------------------------------------");

    //     log("${orderItem.foodMenuModel.toJson()}");
    //   }

    //   log("#############################################");
    // }
  }
}
