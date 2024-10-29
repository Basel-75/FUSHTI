import 'package:get_all_pkg/data/model/order_item_model.dart';

class OrderModel {
  final String id;
  final String childId;
  final String status;
  final num totalPrice;
   final List<OrderItemModel> orderItemModelLis = [];

  OrderModel({
    required this.id,
    required this.childId,
    required this.status,
    required this.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      childId: json['child_id'],
      status: json['status'],
      totalPrice: json['total_price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child_id': childId,
      'status': status,
      'total_price': totalPrice,
    };
  }
}
