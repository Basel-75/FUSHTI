class FoodMenuModel {
  final String id;
  final String schoolId;
  final String foodName;
  final String? description;
  final num price;
  final String category;
  final bool available;
  final int cal;
  final List<String>? allergy;

  FoodMenuModel({
    required this.id,
    required this.schoolId,
    required this.foodName,
    required this.description,
    required this.price,
    required this.category,
    required this.available,
    required this.cal,
    required this.allergy,
  });

  factory FoodMenuModel.fromJson(Map<String, dynamic> json) {
    return FoodMenuModel(
      id: json['id'],
      schoolId: json['school_id'],
      foodName: json['food_name'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'],
      available: json['available'],
      cal: json['cal'],
      allergy: (json['allergy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'school_id': schoolId,
      'food_name': foodName,
      'description': description,
      'price': price,
      'category': category,
      'available': available,
      'cal': cal,
      'allergy': allergy,
    };
  }
}
