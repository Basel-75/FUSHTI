import 'package:get_all_pkg/data/model/school_model.dart';

class EmpModel {
  final String id;
  final String name;
  final int totalOrder;
  final String role;
  final String schoolId;
  final String authId;

  late final SchoolModel schoolModel;

  EmpModel({
    required this.id,
    required this.name,
    required this.totalOrder,
    required this.role,
    required this.schoolId,
    required this.authId,
  });

  factory EmpModel.fromJson(Map<String, dynamic> json) {
    return EmpModel(
      id: json['id'],
      name: json['name'],
      totalOrder: json['total_order'],
      role: json['role'],
      schoolId: json['school_id'],
      authId: json['auth_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'total_order': totalOrder,
      'role': role,
      'school_id': schoolId,
      'auth_id': authId,

      "schoolModel" : schoolModel.toJson()


    };
  }
}
