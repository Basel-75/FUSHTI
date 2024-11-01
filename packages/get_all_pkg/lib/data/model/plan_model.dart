import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/meal_plan_item_model.dart';

class PlanModel {
  final String id;
  final String childId;
  final String startDate;
  final String endDate;
  final int totalMeals;
  final String? status;
  final String? name;

  final List<MealPlanItemModel> mealPlanItemLis = [];

  final List<String> datesTaken;
  final String createDate;

     ChildModel? childModel;


  PlanModel({
    required this.id,
    required this.childId,
    required this.startDate,
    required this.endDate,
    required this.totalMeals,
    required this.status,
    required this.name,
    required this.datesTaken,
    required this.createDate,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      childId: json['child_id'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      totalMeals: json['total_meals'],
      status: json['status'],
      name: json['name'],
      datesTaken: List<String>.from(json['dates_taken']),
      createDate: json["create_date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child_id': childId,
      'start_date': startDate,
      'end_date': endDate,
      'total_meals': totalMeals,
      'status': status,
      "dates_taken": datesTaken,
      "create_date": createDate
    };
  }
}
