import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:meta/meta.dart';

part 'child_serch_state.dart';

class ChildSerchCubit extends Cubit<ChildSerchState> {
  ChildSerchCubit() : super(ChildSerchInitial());

  late final String childName;

  String? childClass;

  List<ChildModel> childLis = [];

  getChilds() async {
    await Future.delayed(const Duration(milliseconds: 300));
    log("in getChilds");
    emit(LoadingState());

    log("name is :::: $childName");
    log("class is :::: $childClass");

    try {
      childLis = await SuperMain()
          .getAllChildernSerch(name: childName, childClass: childClass);

      log(" chidl lis :::::  $childLis");

      emit(SuccessState());
    } catch (er) {
      log("$er");
      emit(ErrorState(msg: "حصل خطأ"));
    }
  }
}
