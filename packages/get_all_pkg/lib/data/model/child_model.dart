import 'package:get_all_pkg/data/model/cart_item.dart';
import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/model/restriction_food_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';

class ChildModel {
  final String id;
  String name;
  final String userId;
  String schoolId;
  String imgPath;
  String studentClass;
  List<String> allergy;
  num funds;
  List<RestrictionFoodModel> restrictionFood = [];
  late final SchoolModel schoolModel;
  List<CartItem> cartList = [];
  final List<PlanModel> planList = [];

  final num dailyLimits;
  final bool isOpenDay;

  ChildModel(
      {required this.id,
      required this.name,
      required this.userId,
      required this.schoolId,
      required this.imgPath,
      required this.studentClass,
      required this.allergy,
      required this.funds,
      required this.dailyLimits,
      required this.isOpenDay});

  factory ChildModel.fromJson(Map<String, dynamic> json) {
    return ChildModel(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
      schoolId: json['school_id'],
      imgPath: json['img_path'],
      studentClass: json['class'],
      allergy: List<String>.from(json['allergy']),
      funds: json['funds'].toDouble(),
      dailyLimits: json["daily_limit"],
      isOpenDay: json["is_open_day"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'user_id': userId,
      'school_id': schoolId,
      'img_path': imgPath,
      'class': studentClass,
      'allergy': allergy,
      'funds': funds,
      "daily_limit" : dailyLimits,
      "is_open_day" : isOpenDay
    };
  }
}
