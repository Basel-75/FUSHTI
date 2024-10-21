import 'package:bloc/bloc.dart';
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
}
