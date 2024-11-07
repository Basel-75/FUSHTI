import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/widgets.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/cart_item.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/restriction_food_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  AppModel appModel = getIt.get<AppModel>();

  List<ChildModel> childModelList = [];

  late ChildModel currentChild;
  List<FoodMenuModel> boxList = [];
  List<FoodMenuModel> productList = [];
  List<FoodMenuModel> bestProductList = [];

  TextEditingController priceTotal = TextEditingController();

  initHome() {
    childModelList = appModel.userModel!.childModelList;

    currentChild = childModelList.first;
    currentChild.isSelected = true;
    for (var element in currentChild.schoolModel.foodMenuModelList) {
      bool hasAllergy = element.allergy != null
          ? element.allergy!
              .any((allergy) => currentChild.allergy.contains(allergy))
          : false;
      if ((element.category == 'box' || element.category == 'بوكس') &&
          !hasAllergy) {
        boxList.add(element);
      } else if ((element.category == 'product' ||
              element.category == 'منتج') &&
          !hasAllergy) {
        productList.add(element);
      }
    }
  }

  changeChild(ChildModel child) {
    if (child != currentChild) {
      boxList.clear();
      productList.clear();
      bestProductList.clear();
      currentChild.isSelected = false;

      getBestProduct();
      currentChild = child;
      currentChild.isSelected = true;

      for (var element in currentChild.schoolModel.foodMenuModelList) {
        bool hasAllergy = element.allergy != null
            ? element.allergy!
                .any((allergy) => currentChild.allergy.contains(allergy))
            : false;
        if ((element.category == 'box' || element.category == 'بوكس') &&
            !hasAllergy) {
          boxList.add(element);
        } else if ((element.category == 'product' ||
                element.category == 'منتج') &&
            !hasAllergy) {
          productList.add(element);
        }
      }

      emit(ChangeChildState());
    }
  }

  addToRestrictionsFood(
      {required String childId, required String productId}) async {
    try {
      emit(LoadingState());
      //update in DB
      await SuperMain().addToRestrictionsFood(
        childId: childId,
        productId: productId,
      );

      //update locale
      currentChild.restrictionFood.add(RestrictionFoodModel(
        childId: childId,
        menuItemId: productId,
      ));
      for (var element in appModel.userModel!.childModelList) {
        if (element.id == childId) {
          element.restrictionFood.add(RestrictionFoodModel(
            childId: childId,
            menuItemId: productId,
          ));
        }
      }
      emit(SussesState(msg: 'تم حظر المنتج بنجاح'));
    } catch (e) {
      emit(ErrorState(msg: 'حدث خطأ ما يرجى المحاولة لاحقا'));
    }
  }

  bool checkRestrictionsFood({required String productId}) {
    bool result = false;
    for (var element in appModel.userModel!.childModelList) {
      for (var food in element.restrictionFood) {
        if (food.menuItemId == productId) {
          result = true;
        }
      }
    }
    emit(CheckState());
    return result;
  }

  quickAddToCart(
      {required ChildModel childModel, required FoodMenuModel foodMenuModel}) {
    for (var val in childModel.cartList) {
      if (val.foodMenuModel.id == foodMenuModel.id) {
        emit(CartThereState());
        return;
      }
    }

    childModel.cartList.add(
        CartItem(childModel: childModel, foodMenuModel: foodMenuModel, que: 1));

    emit(DoneAddState(msg: 'تم اضافة المنتج الى السلة'));
  }

  @override
  Future<void> close() {
    for (var element in appModel.userModel!.childModelList) {
      element.isSelected = false;
    }
    return super.close();
  }

  getBestProduct() async {
    try {
      final bestProduct = await SuperMain().getBestThreeProduct();
      for (var element in bestProduct) {
        bestProductList.add(FoodMenuModel.fromJson(element));
      }
    } catch (e) {}
  }
}
