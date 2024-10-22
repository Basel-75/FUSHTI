import 'package:get_all_pkg/data/model/plan_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';

class ChildModel {
  final String id;
  final String name;
  final String userId;
  final String schoolId;
  final String imgPath;
  final String studentClass;
  final List<String> allergy;
  final num funds;
  late final SchoolModel schoolModel;
  final List<PlanModel> planList = [];

  ChildModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.schoolId,
    required this.imgPath,
    required this.studentClass,
    required this.allergy,
    required this.funds,
  });

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
    };
  }
}
