import 'dart:developer';
import 'dart:io';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

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
      log('$foodRes==========1');
      for (var val in foodRes) {
        appModel.empModel!.schoolModel.foodMenuModelList
            .add(FoodMenuModel.fromJson(val));
      }
    } catch (er) {
      log("$er");
    }
  }

  deleteProduct({required String productId}) async {
    try {
      await SuperMain().supabase.from('food_menu').delete().eq('id', productId);
    } catch (e) {
      log('$e');
    }
  }

  Future<void> addProduct({required FoodMenuModel product}) async {
    try {
      final response = await SuperMain().supabase.from('food_menu').insert({
        'school_id': product.schoolId,
        'food_name': product.foodName,
        'description': product.description,
        'price': product.price,
        'category': product.category,
        'available': product.available,
        'cal': product.cal,
        'allergy': product.allergy,
        'image_url': product.imageUrl,
      }).select();

      log('$response');
    } catch (e) {
      log('$e');
    }
  }
}
