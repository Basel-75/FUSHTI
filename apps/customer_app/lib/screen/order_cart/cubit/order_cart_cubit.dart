import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';

import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/cart_item.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'order_cart_state.dart';

class OrderCartCubit extends Cubit<OrderCartState> {
  OrderCartCubit() : super(OrderCartInitial());

  AppModel appModel = getIt.get<AppModel>();

  late ChildModel childModel;

  double totalPrice = 0;

  onAdd({required CartItem cartItem}) {
    cartItem.que += 1;

    emit(ChangeQueState());
  }

  onMinus({required CartItem cartItem}) {
    if (cartItem.que != 1) {
      cartItem.que -= 1;

      emit(ChangeQueState());
    }
  }

  String calculateCal() {
    int totalCal = 0;

    for (var val in childModel.cartList) {
      totalCal += val.foodMenuModel.cal * val.que;
    }

    return totalCal.toString();
  }

  String calculateTotal() {
    totalPrice = 0;

    for (var val in childModel.cartList) {
      totalPrice += val.foodMenuModel.price * val.que;
    }

    return totalPrice.toString();
  }

  payPlan() async {
    try {
      log("user funds :::: ${appModel.userModel!.funds}");

      if (appModel.userModel!.funds < totalPrice) {
        emit(ErorrState(msg: "you dont have money"));
        return;
      }

      if (childModel.cartList.isEmpty) {
        emit(ErorrState(msg: "لا توجد منتجات في السلة"));

        return;
      }

      await SuperMain()
          .payForOrder(totalPrice: totalPrice, childModel: childModel);

      log("user funds :::: ${appModel.userModel!.funds}");
      log("very good order pay");
    } catch (er) {
      log("$er");

      emit(ErorrState(msg: er.toString()));
    }
  }

  delItem({required int cartIndex}) {
    childModel.cartList.removeAt(cartIndex);
    emit(ChangeQueState());
  }
}
