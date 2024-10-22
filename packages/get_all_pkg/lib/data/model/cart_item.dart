import 'package:get_all_pkg/data/model/child_model.dart';

import 'package:get_all_pkg/data/model/food_menu_model.dart';

class CartItem {
  final ChildModel childModel;

  final FoodMenuModel foodMenuModel;

  int que;

  CartItem(
      {required this.childModel,
      required this.foodMenuModel,
      required this.que});

  Map<String, dynamic> toJson() {
    return {

      "childModel" : childModel.toJson(),

      "foodMenuModel" : foodMenuModel.toJson(),
      "que" : que




    };
  }
}
