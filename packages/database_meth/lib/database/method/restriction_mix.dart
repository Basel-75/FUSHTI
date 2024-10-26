import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/restriction_food_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin RestrictionMix {
  getRestrictionFood() async {
    var restrictionFoodList =
        await SuperMain().supabase.from('food_restriction').select();
    for (var element in restrictionFoodList) {
      for (var food in getIt.get<AppModel>().userModel!.childModelList) {
        food.restrictionFood.add(RestrictionFoodModel.fromJson(element));
      }
    }
  }

  addToRestrictionsFood({
    required String childId,
    required String productId,
  }) async {
    await SuperMain()
        .supabase
        .from('food_restriction')
        .insert({'child_id': childId, 'menu_item_id': productId,});
  }

  deleteRestrictionFood({required String productId}) async {
    await SuperMain().supabase.from('food_restriction').delete().eq('menu_item_id', productId);
  }
}
