import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'followers_profile_state.dart';

class FollowersProfileCubit extends Cubit<FollowersProfileState> {
  FollowersProfileCubit() : super(FollowersProfileInitial());
  int totalMelsInPlan = 0;
  countTotal({required String id}) {
    for (var i in appModel.userModel!.childModelList) {
      log('${i.planList}');
      for (var j in i.planList) {
        log('${j.toJson()}');
        totalMelsInPlan += j.totalMeals;
      }
    }
  }

  AppModel appModel = getIt.get<AppModel>();
}
