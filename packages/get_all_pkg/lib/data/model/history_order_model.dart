import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/order_model.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';

class HistoryOrderModel {
   final ChildModel childModel;

  final OrderModel? orderModel;

  final PlanModel? planModel;

  HistoryOrderModel({ required this.childModel, this.orderModel, this.planModel});

  // factory HistoryModel.fromJson(Map<String, dynamic> json) {
  //   return HistoryModel(


  //     orderModel = OrderModel.fromJson(json["order"])


  //   );
  // }
}
