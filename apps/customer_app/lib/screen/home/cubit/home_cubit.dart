import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  AppModel appModel = getIt.get<AppModel>();

  List<ChildModel> childModelList = [];

  late ChildModel currentChild;

  initHome() {
    childModelList = appModel.userModel!.childModelList;

    log("there is ${childModelList.length}");

    currentChild = childModelList.first;
  }

  chnageChild(ChildModel child) {
    if (child != currentChild) {
      log("in if change child");
      currentChild = child;
      emit(ChnageChildState());
    }
  }
}
