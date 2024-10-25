class RestrictionFoodModel {
  final String childId;
  final String menuItemId;

  RestrictionFoodModel({
    required this.childId,
    required this.menuItemId,
  });

  factory RestrictionFoodModel.fromJson(Map<String, dynamic> json) {
    return RestrictionFoodModel(
      childId: json['child_id'],
      menuItemId: json['menu_item_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
      'menu_item_id': menuItemId,
    };
  }
}
