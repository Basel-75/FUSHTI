import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/widgets.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/cart_item.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  AppModel appModel = getIt.get<AppModel>();

  TextEditingController planItemCOn = TextEditingController();

  late final FoodMenuModel foodMenuModel;
  late final ChildModel childModel;

  addToCart(
      {required ChildModel childModel, required FoodMenuModel foodMenuModel}) {
    for (var val in appModel.cartList) {
      if (val.foodMenuModel.id == foodMenuModel.id) {
        emit(CartThereState());
        return;
      }
    }

    appModel.cartList.add(
        CartItem(childModel: childModel, foodMenuModel: foodMenuModel, que: 1));

    emit(DoneAddState());
  }

  addToPlan() async {
    log("in add plan");
    if (planItemCOn.text.isEmpty) {
      emit(EorrState(msg: "chose plan"));
      return;
    }
    try {
      await SuperMain().addPlanItem(
          name: planItemCOn.text,
          childModel: childModel,
          foodMenuModel: foodMenuModel);

      emit(DoneAddState());
    } catch (er) {
      log("$er");
      emit(EorrState(msg: "thre was eorr"));
    }
  }
}
