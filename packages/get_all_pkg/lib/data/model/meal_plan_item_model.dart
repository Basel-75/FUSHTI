import 'package:get_all_pkg/data/model/food_menu_model.dart';

class MealPlanItemModel {
  final String id;
  final String mealPlanId;
  final String menuItemId;
   int quantity;
  late final FoodMenuModel foodMenuModel;

  MealPlanItemModel({
    required this.id,
    required this.mealPlanId,
    required this.menuItemId,
    required this.quantity,
    
  });

  factory MealPlanItemModel.fromJson(Map<String, dynamic> json) {
    return MealPlanItemModel(
      id: json['id'],
      mealPlanId: json['meal_plan_id'],
      menuItemId: json['menu_item_id'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'meal_plan_id': mealPlanId,
      'menu_item_id': menuItemId,
      'quantity': quantity,
    };
  }
}
