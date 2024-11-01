import 'dart:developer';

import 'package:get_all_pkg/data/model/cart_item.dart';
import 'package:get_all_pkg/data/model/emp_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/model/user_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AppModel {
  final box = GetStorage();
  UserModel? userModel = UserModel(
    id: "35d625c6-a6b1-4089-a638-f87c776aab2b",
    name: "ammar",
    funds: 0,
    numberFollowers: 0,
    authId: "a2e2bb17-c48a-4ff2-bec3-072cb2bbb0f0",
    phone: "0544111111",
  );

  EmpModel? empModel;

  List<SchoolModel> schoolModelList = [];
  List<String> alergy = ['الفول السوداني', "الذرة"];

  // List<CartItem> cartList = [];

  saveUser(UserModel newUser) {
    userModel = newUser;

    log("${userModel!.toJson()}");
  }

  Future<void> saveAuth({required UserModel userData}) async {
    OneSignal.login(userData.id);
    userModel = userData;
    await box.write("user", userData.toJson());
  }
}
