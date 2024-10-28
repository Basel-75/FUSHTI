import 'package:get_all_pkg/data/model/child_model.dart';

class UserModel {
  String id;
  String name;
  num funds;
  int numberFollowers;
  String phone;
  String authId;
  List<ChildModel> childModelList = [];
  final String? imageUrl;

  UserModel(
      {required this.id,
      required this.name,
      required this.funds,
      required this.numberFollowers,
      required this.authId,
      required this.phone,
      this.imageUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      funds: json['funds'],
      numberFollowers: json['number_followers'],
      authId: json['auth_id'],
      phone: json['phone'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'funds': funds,
      'number_followers': numberFollowers,
      'phone': phone,
      'image_url': imageUrl,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    num? funds,
    int? numberFollowers,
    String? phone,
    String? authId,
    List<ChildModel>? childModelList,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      funds: funds ?? this.funds,
      numberFollowers: numberFollowers ?? this.numberFollowers,
      phone: phone ?? this.phone,
      authId: authId ?? this.authId,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
