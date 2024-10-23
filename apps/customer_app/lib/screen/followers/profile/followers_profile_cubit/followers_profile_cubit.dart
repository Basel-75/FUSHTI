import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'followers_profile_state.dart';

class FollowersProfileCubit extends Cubit<FollowersProfileState> {
  FollowersProfileCubit() : super(FollowersProfileInitial());
  int totalMealsInPlan = 0;
  countTotal({required String id}) {
    for (var i in appModel.userModel!.childModelList) {
      log('${i.planList}');
      for (var j in i.planList) {
        log('${j.toJson()}');
        totalMealsInPlan += j.totalMeals;
      }
    }
  }

  deleteChild({required String childId}) async {
    try {
      //Delete in DB
      emit(LoadingState());
      await SuperMain().deleteChild(id: childId);
      //Delete Locale
      appModel.userModel?.childModelList.removeWhere((element) => element.id==childId,);
      emit(SuccessState(msg: 'تم حذف التابع بنجاح'));
    } catch (e) {
      emit(ErrorState(msg: 'تعذر حذف التابع اعد المحاولة لاحقا'));
    }
  }

  AppModel appModel = getIt.get<AppModel>();
}
