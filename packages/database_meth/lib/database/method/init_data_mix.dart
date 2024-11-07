import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/restriction_food_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin InitDataMix {
  getSchool() async {
    try {
      var schollLis = await SuperMain().supabase.from("school").select();

      for (var val in schollLis) {
        getIt.get<AppModel>().schoolModelList.add(SchoolModel.fromJson(val));
      }
    } catch (er) {}
  }

  getRestrictionFood() async {
    var restrictionFoodList =
        await SuperMain().supabase.from('food_restriction').select();
    for (var element in restrictionFoodList) {
      for (var food in getIt.get<AppModel>().userModel!.childModelList) {
        food.restrictionFood.add(RestrictionFoodModel.fromJson(element));
      }
    }
  }
}
