import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin ChildMix {
  getChilds() async {
    AppModel appModel = getIt.get<AppModel>();
    // try {
      final childLis = await SuperMain()
          .supabase
          .from("followers")
          .select()
          .eq("user_id", appModel.userModel!.id);

// can add triger here
      for (var val in childLis) {
        appModel.userModel!.childModelList.add(ChildModel.fromJson(val));
      }

      for (var val in appModel.userModel!.childModelList) {
        final schollRes = await SuperMain()
            .supabase
            .from("school")
            .select()
            .eq("id", val.schoolId);

        val.schoolModel = SchoolModel.fromJson(schollRes[0]);

        final foodRes = await SuperMain()
            .supabase
            .from("food_menu")
            .select()
            .eq("school_id", val.schoolModel.id);

        for (var food in foodRes) {
          val.schoolModel.foodMenuModelList.add(FoodMenuModel.fromJson(food));
        }
      }

      log("${appModel.userModel!.childModelList[0].toJson()}");
      log("${appModel.userModel!.childModelList[0].schoolModel.toJson()}");
      log("${appModel.userModel!.childModelList[0].schoolModel.foodMenuModelList[0].toJson()}");
    // } catch (er) {
    //   log("$er");
    // }
  }

  addChild(
      {required String name,
      required String userId,
      required List<String> allergy,
      required String clas,
      required String imgPath,
      required String schoolId,
      required double funds}) async {
    try {
      await SuperMain().supabase.from("followers").insert({
        "name": name,
        "user_id": userId,
        "funds": funds,
        "allergy": allergy,
        "class": clas,
        "img_path": imgPath,
        "school_id": schoolId,
      });

      await SuperMain().supabase.rpc('increment_followers', params: {
        'user_id': userId,
      });
    } catch (er) {
      log("$er");
    }
  }
}