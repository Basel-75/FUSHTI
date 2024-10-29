import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:employee_app/component/drop_down_item.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/model/scan_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  late ChildModel childModel;

  AppModel appModel = getIt.get<AppModel>();

  List<OrderModel> orderLis = [];

  List<ScanModel> scanLis = [];

  PlanModel? plan;

  List<DropDownItem> foodDropList = [];
  OrderModel? selctFoodOrder;

  double dailyLimitTotal = 0;

  queAdd({required OrderItemModel orderItem}) {
    orderItem.quantity += 1;

    dailyLimitTotal += orderItem.foodMenuModel.price;

    emit(DoneState());
  }

  queMin({required OrderItemModel orderItem}) {
    if (orderItem.quantity != 1) {
      orderItem.quantity -= 1;
      dailyLimitTotal -= orderItem.foodMenuModel.price;
    }

    emit(DoneState());
  }

  addtoScan() {
    for (var val in orderLis) {
      for (var item in val.orderItemModelLis) {
        scanLis.add(ScanModel(
            foodMenuModel: item.foodMenuModel,
            que: item.quantity,
            isDily: false));
      }
    }

    if (plan != null) {
      for (var val in plan!.mealPlanItemLis) {
        scanLis.add(ScanModel(
            foodMenuModel: val.foodMenuModel,
            que: val.quantity,
            isDily: false));
      }
    }
  }

  addFromDrop({required List<DropDownItem> dropList}) {
    dailyLimitTotal = 0;
    if (dropList.isEmpty) {
      scanLis.clear();
      addtoScan();

      selctFoodOrder = null;

      emit(DoneState());

      return;
    }

    selctFoodOrder ??= OrderModel(
        id: "id",
        childId: childModel.id,
        status: "open_day",
        totalPrice: 0,
        createDate: DateTime.now().toIso8601String().split('T')[0]);
    scanLis.clear();

    addtoScan();
//  to bring app the model from school menu
    for (var val in dropList) {
      for (var food in appModel.empModel!.schoolModel.foodMenuModelList) {
        if (val.name == food.foodName) {
          dailyLimitTotal += food.price;
          // temp varible so the two list share same refence will help when we up or down the que in the ui
          final temp = OrderItemModel(
              id: "id", orderId: "orderId", quantity: 1, menuId: food.id);

          temp.foodMenuModel = food;
          selctFoodOrder!.orderItemModelLis.add(temp);
          scanLis.add(ScanModel(
              foodMenuModel: food, que: 0, isDily: true, orderItemModel: temp));
        }
      }
    }

    emit(DoneState());
  }

  getAllCHildOrder() async {
    try {
      scanLis.clear();
      orderLis.clear();

      log("in methd 1");
      // await Future.delayed(Duration(milliseconds: 300));
      log("in methd 2");

      // get the scholl drop dwon menu item ready

      for (var val in appModel.empModel!.schoolModel.foodMenuModelList) {
        foodDropList.add(DropDownItem(val.foodName));
      }
      emit(LodingState());
      final res = await SuperMain().getChildOrder(childModel: childModel);

//  first order model
      for (var val in res) {
        orderLis.add(OrderModel.fromJson(val));
      }

// then orderItem

      for (var val in orderLis) {
        await SuperMain().orderInfo(orderModel: val);
      }

      plan = await SuperMain().getChildPlan(childModel: childModel);

      // log("${planModelLis[0].status}");

      // add all food menu with que in this list to show up in ui

      for (var val in orderLis) {
        for (var item in val.orderItemModelLis) {
          scanLis.add(ScanModel(
              foodMenuModel: item.foodMenuModel,
              que: item.quantity,
              isDily: false));
        }
      }

      if (plan != null) {
        for (var val in plan!.mealPlanItemLis) {
          scanLis.add(ScanModel(
              foodMenuModel: val.foodMenuModel,
              que: val.quantity,
              isDily: false));
        }
      }

      log("this scan list lenth ${scanLis.length}");

      emit(DoneState());
    } catch (er) {
      log("$er");

      emit(ErorState(msg: er.toString()));
      rethrow;
    }
  }
}
