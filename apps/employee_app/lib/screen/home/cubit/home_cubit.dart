import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  AppModel appModel = getIt.get<AppModel>();
  List<FoodMenuModel> boxItems = [];
  List<FoodMenuModel> menu =
      getIt.get<AppModel>().empModel!.schoolModel.foodMenuModelList;
  HomeCubit() : super(HomeInitial());

  filterBoxItems() {
    boxItems = menu.where((item) => item.category == 'بوكس').toList();
    emit(HomeInitial()); // تحديث الحالة وإعلام الواجهة بالتغيير
  }

  deleteProduct({required String productId}) async {
    try {
      emit(LoadingState());
      //Delete in DB
      await SuperMain().deleteProduct(productId: productId);
      //Delete Locale
      menu.removeWhere(
        (element) => element.id == productId,
      );
      emit(SuccessState(msg: 'تم حذف المنتج بنجاح'));
    } catch (e) {
      emit(ErrorState(msg: 'تعذر حذف المنتج حاول مرة اخرى'));
      log('$e');
    }
  }

  refreshProducts() {
    emit(HomeInitial()); // Emit initial state to trigger a rebuild
  }
}
