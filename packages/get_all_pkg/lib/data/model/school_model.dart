


import 'package:get_all_pkg/data/model/food_menu_model.dart';

class SchoolModel {

  final String id;
  final String name;
  final String adders;
  final String contactNumber;
  final List<FoodMenuModel> foodMenuModelList = [];

  SchoolModel({
    required this.id,
    required this.name,
    required this.adders,
    required this.contactNumber,
  });

  
  factory SchoolModel.fromJson(Map<String, dynamic> json) {
    return SchoolModel(
      id: json['id'],
      name: json['name'],
      adders: json['adders'],
      contactNumber: json['contact_number'],
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'adders': adders,
      'contact_number': contactNumber,
    };
  }
}