import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:employee_app/component/drop_down_item.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';

import 'package:get_all_pkg/helper/one_signal.dart';

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
  double preDailyLimitTotal = 0;

  queAdd({required OrderItemModel orderItem}) {
    orderItem.quantity += 1;

    dailyLimitTotal += orderItem.foodMenuModel.price;

    emit(QueUpdateState());
  }

  queMin({required OrderItemModel orderItem}) {
    if (orderItem.quantity != 1) {
      orderItem.quantity -= 1;
      dailyLimitTotal -= orderItem.foodMenuModel.price;
    }

    emit(QueUpdateState());
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
  }

  orderStatusNotification(
      {required String status,
      required String childId,
      required String customerId}) async {
    try {
      log("here");
      emit(LodingState());
      await Onesignal().pushNote(msg: 'test $status', userId: customerId);
      //msg: 'Hi your order is $status', userId: customerId
      emit(NoLodingState());
      //getChildOrder();
    } catch (er) {
      log("$er");
      emit(ErorState(msg: "حصل خطأ ما يرجى المحاولة لاحقا"));

      if (plan != null) {
        for (var val in plan!.mealPlanItemLis) {
          scanLis.add(ScanModel(
              foodMenuModel: val.foodMenuModel,
              que: val.quantity,
              isDily: false));
        }
      }
    }
  }

  addFromDrop({required List<DropDownItem> dropList}) {
    emit(LodingState());
    dailyLimitTotal = 0;
    if (dropList.isEmpty) {
      scanLis.clear();
      addtoScan();

      selctFoodOrder = null;

      emit(DoneState());

      return;
    }

    if (selctFoodOrder == null) {
      selctFoodOrder = OrderModel(
          id: "id",
          childId: childModel.id,
          status: "open_day",
          totalPrice: 0,
          createDate: DateTime.now().toIso8601String().split('T')[0]);
    } else {
      selctFoodOrder?.orderItemModelLis.clear();
    }

    scanLis.clear();

    addtoScan();
//  to bring app the model from school menu
    for (var val in dropList) {
      for (var food in appModel.empModel!.schoolModel.foodMenuModelList) {
        if (val.name == food.foodName) {
          log("in check add form drop in if");
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
    log(DateTime.now().toIso8601String().split('T')[0]);
    await Future.delayed(const Duration(milliseconds: 300));
    emit(LodingState());
    try {
      scanLis.clear();
      orderLis.clear();

      preDailyLimitTotal =
          await SuperMain().bringPreOrderLimt(childModel: childModel);

      for (var val in appModel.empModel!.schoolModel.foodMenuModelList) {
        foodDropList.add(DropDownItem(val.foodName));
      }

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

      emit(ErorState(msg: 'حصل خطأ ما يرجى المحاولة لاحقا'));
      rethrow;
    }
  }

  checkOut() async {
    log("  check this  ${selctFoodOrder?.orderItemModelLis.length}");
    emit(LodingState());
    if (dailyLimitTotal + preDailyLimitTotal > childModel.dailyLimits) {
      emit(ErorState(msg: "قيمة الطلب اكبر من الحد اليومي"));
      return;
    }

    if (childModel.funds < dailyLimitTotal) {
      emit(ErorState(msg: "الرصيد غير كافي لاتمام الطلب"));
      return;
    }

    try {
      await SuperMain().checkOutOrder(
          planModel: plan,
          selctFoodOrder: selctFoodOrder,
          orderLis: orderLis,
          childModel: childModel,
          dailyLimitTotal: dailyLimitTotal);

      emit(DoneState());
    } catch (er) {
      log("$er");
      emit(ErorState(msg: 'حصل خطأ ما يرجى المحاولة لاحقا'));
    }
  }
}
