import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin EmpMix {

  
  getEmpSchool() async {
    try {
      AppModel appModel = getIt.get<AppModel>();

      final schollRes = await SuperMain()
          .supabase
          .from("school")
          .select()
          .eq("id", appModel.empModel!.schoolId);

      appModel.empModel!.schoolModel = SchoolModel.fromJson(schollRes[0]);


        final foodRes = await SuperMain()
            .supabase
            .from("food_menu")
            .select()
            .eq("school_id", appModel.empModel!.schoolModel.id);


            for(var val in foodRes){

               appModel.empModel!.schoolModel.foodMenuModelList.add(FoodMenuModel.fromJson(val));


            }
    } catch (er) {
      log("$er");
    }
  }
}
