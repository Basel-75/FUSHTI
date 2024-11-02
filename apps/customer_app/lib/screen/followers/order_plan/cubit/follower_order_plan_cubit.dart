import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/child_model.dart';

import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'follower_order_plan_state.dart';

class FollowerOrderPlanCubit extends Cubit<FollowerOrderPlanState> {
  FollowerOrderPlanCubit() : super(FollowerOrderPlanInitial());

  AppModel appModel = getIt.get<AppModel>();

  late ChildModel childModel;

  List<OrderModel> lisOrder = [];
  List<PlanModel> planLis = [];

  bool isOrder = true;

  tabClick({required String tabName}) {
    emit(LodingState());
    if (tabName == "order") {
      isOrder = true;
    } else {
      isOrder = false;
    }

    emit(DoneState());
  }

  historyBring() async {
    try {
      await Future.delayed(Duration.zero);
      emit(LodingState());

      lisOrder = await SuperMain().bringOrder(childModel: childModel);

      planLis = await SuperMain().bringPlan(childModel: childModel);

      emit(DoneState());
    } catch (er) {
      log("$er");
      rethrow;
    }
  }
}
