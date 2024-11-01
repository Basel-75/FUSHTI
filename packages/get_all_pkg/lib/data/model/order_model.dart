import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';

class OrderModel {
  final String id;
  final String childId;
  final String status;
  final num totalPrice;
  final List<OrderItemModel> orderItemModelLis = [];

   ChildModel? childModel;

  final String createDate;

  OrderModel({
    required this.id,
    required this.childId,
    required this.status,
    required this.totalPrice,
    required this.createDate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        childId: json['child_id'],
        status: json['status'],
        totalPrice: json['total_price'],
        createDate: json["create_date"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child_id': childId,
      'status': status,
      'total_price': totalPrice,
      "create_date": createDate
    };
  }
}
