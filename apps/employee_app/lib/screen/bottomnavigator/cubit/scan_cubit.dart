import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/widgets.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:meta/meta.dart';

part 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  ScanCubit() : super(ScanInitial());

  ChildModel? childModel;

  TextEditingController childNameCon = TextEditingController();
  TextEditingController childClassCon = TextEditingController();

  // getchild() async {
  //   final res = await SuperMain()
  //       .getChildById(childId: "d89d5dd5-5487-4065-9116-9d1bfe271000");

  //   childModel = ChildModel.fromJson(res);
  // }

  bool checkTheCOn() {
    if (childNameCon.text.isEmpty) {
      emit(ErorState(msg: "يرجى ادخال اسم الطالب"));
      return false;
    }

    return true;
  }
}
