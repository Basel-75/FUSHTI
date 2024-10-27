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

  getChildOrder() async {
    final res = await SuperMain().getChildOrder(childModel: childModel);

//  first order model
    for (var val in res) {
      orderLis.add(OrderModel.fromJson(val));
    }

// then orderItem

    for (var val in orderLis) {
      await SuperMain().orderInfo(orderModel: val);
    }

    final planRes = await SuperMain().getChildPlan(childModel: childModel);


    
  }
}
