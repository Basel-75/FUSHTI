import 'dart:developer';

import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/model/user_model.dart';

class AppModel {
  UserModel? userModel;

  List<SchoolModel> schoolModelList = [];

  saveUser(UserModel newUser) {
    userModel = newUser;

    log("${userModel!.toJson()}");
  }
}
