import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/food_menu_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit() : super(StorageInitial());

  AppModel appModel = getIt.get<AppModel>();

  late final SchoolModel schoolModel = appModel.empModel!.schoolModel;

  List<FoodMenuModel> foodAdvChangeList = [];

  onAdvChange({required FoodMenuModel foodModel}) {
    if (!foodAdvChangeList.contains(foodModel)) {
      foodModel.available = !foodModel.available;
      foodAdvChangeList.add(foodModel);
    }
  }

  updateAdv() async {
    try {
      emit(LoadingState());

      await SuperMain().chnageFoodAdv(foodAdvChangeList: foodAdvChangeList);

      foodAdvChangeList.clear();

      emit(DoneState());
    } catch (er) {
      emit(ErrorState(msg: 'حصل خطأ ما يرجى المحاولة لاحقا'));
    }
  }
}
