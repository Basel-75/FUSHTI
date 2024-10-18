import 'dart:developer';

import 'package:get_all_pkg/data/model/user_model.dart';

class AppModel {
  UserModel? userModel;

  saveUser(UserModel newUser) {
    userModel = newUser;

    log("${userModel!.toJson()}");
  }
}
