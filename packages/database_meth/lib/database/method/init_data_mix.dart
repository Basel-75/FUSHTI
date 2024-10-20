import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin InitDataMix {
  getSchool() async {
    // try {
    var schollLis = await SuperMain().supabase.from("school").select();

    log("iam in scholllll");
    log("$schollLis");

    for (var val in schollLis) {
      getIt.get<AppModel>().schoolModelList.add(SchoolModel.fromJson(val));
    }

    // final foodMenu = await SuperMain().supabase.from("food_menu").select();

    // for (var val in getIt.get<AppModel>().schoolModelList) {
    //   for (var food in foodMenu) {
    //     if (val.id == food["school_id"]) {
    //       val.foodMenuModelList.add(FoodMenuModel.fromJson(food));
    //     }
    //   }
    // }
    
    // } catch (er) {
    //   log("$er");
    // }
  }
}
