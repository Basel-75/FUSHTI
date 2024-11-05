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

  bool isOrder = true;

  tabClick({required String tabName}) {
    emit(LoadingState());
    if (tabName == "order") {
      isOrder = true;
    } else {
      isOrder = false;
    }

    emit(DoneState());
  }

  historyBring() async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      emit(LoadingState());

      final res = await SuperMain().orderHistory();

      for (var val in res) {
        if (val.orderModel != null) {
          lisOrder.add(val.orderModel!);
        } else if (val.planModel != null) {
          planLis.add(val.planModel!);
        }
      }

      emit(DoneState());
    } catch (er) {
      emit(ErrorState(msg: '$er'));
    }
  }
}
