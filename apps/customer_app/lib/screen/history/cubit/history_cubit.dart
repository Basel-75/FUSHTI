import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryCubit() : super(HistoryInitial());

  AppModel appModel = getIt.get<AppModel>();

  List<OrderModel> lisOrder = [];
  List<PlanModel> planLis = [];

  historyBring() async {
    try {
      await Future.delayed(Duration(milliseconds: 300));
      emit(LodingState());

      final res = await SuperMain().orderHistory();

      for (var val in res) {
        log("${val.orderModel!.toJson()}");

        for (var item in val.orderModel!.orderItemModelLis) {
          log("${item.toJson()}");
          log("${item.foodMenuModel.toJson()}");
        }
      }

      emit(DoneState());
    } catch (er) {
      log("$er");
      rethrow;
    }
  }
}
