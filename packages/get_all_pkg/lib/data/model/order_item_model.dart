import 'package:get_all_pkg/data/model/food_menu_model.dart';

class OrderItemModel {
  final String id;
  final String orderId;
   int quantity;
  final String menuId;

   late FoodMenuModel foodMenuModel;

  OrderItemModel({
    required this.id,
    required this.orderId,
    required this.quantity,
    required this.menuId,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'],
      orderId: json['order_id'],
      quantity: json['quantity'],
      menuId: json['menu_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'quantity': quantity,
      'menu_id': menuId,
    };
  }
}
