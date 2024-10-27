import 'dart:developer';

import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';

mixin StorgeMix {
  chnageFoodAdv({required List<FoodMenuModel> foodAdvChangeList}) async {
    try {

  //  can chnage to rpc
      for(var val in foodAdvChangeList){


        await SuperMain().supabase.from("food_menu").update({

        "available" : val.available
      }).eq("id", val.id);

      }
      
    } catch (er) {
      log("$er");
    }
  }
}
