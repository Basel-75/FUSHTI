import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/setup.dart';

mixin OrderMix {
  payForOrder(
      {required double totalPrice, required ChildModel childModel}) async {
    try {
      AppModel appModel = getIt.get<AppModel>();
      await SuperMain().supabase.rpc("decrement_funds",
          params: {"user_id": appModel.userModel!.id, "amount": totalPrice});

      appModel.userModel!.funds -= totalPrice;

      final orderRes = await SuperMain().supabase.from("orders").insert({
        "child_id": childModel.id,
        "status": "active",
        "total_price": totalPrice
      }).select();

      for (var val in childModel.cartList) {
        await SuperMain().supabase.from("order_item").insert({
          "order_id": orderRes[0]["id"],
          "quantity": val.que,
          "menu_id": val.foodMenuModel.id
        }).select();
      }
    } catch (er) {}
  }
}
