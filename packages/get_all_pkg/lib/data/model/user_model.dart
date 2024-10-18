class UserModel {
  final String id;
  final String name;
  final num funds;
  final int numberFollowers;
  final String phone;
  final String authId;

  UserModel({
    required this.id,
    required this.name,
    required this.funds,
    required this.numberFollowers,
    required this.authId,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      funds: json['funds'],
      numberFollowers: json['number_followers'],
      authId: json['auth_id'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'funds': funds,
      'number_followers': numberFollowers,
      'phone': phone,
    };
  }
}
