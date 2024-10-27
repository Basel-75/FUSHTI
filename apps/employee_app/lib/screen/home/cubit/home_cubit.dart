import 'package:bloc/bloc.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  AppModel appModel = getIt.get<AppModel>();
  List<FoodMenuModel> menu =
      getIt.get<AppModel>().empModel!.schoolModel.foodMenuModelList;
  HomeCubit() : super(HomeInitial());
}
