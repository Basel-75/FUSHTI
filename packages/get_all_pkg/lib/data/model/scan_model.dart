import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/order_item_model.dart';

class ScanModel {
  final FoodMenuModel foodMenuModel;
  final int que;
  final bool isDily;

  OrderItemModel? orderItemModel;

  ScanModel(
      {required this.foodMenuModel, required this.que, required this.isDily , this.orderItemModel});
}
