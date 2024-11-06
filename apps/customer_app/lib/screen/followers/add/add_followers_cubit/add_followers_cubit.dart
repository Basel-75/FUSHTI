import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/component/drop_down_item.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/widgets.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

part 'add_followers_state.dart';

class AddFollowersCubit extends Cubit<AddFollowersState> {
  AddFollowersCubit() : super(AddFollowersInitial());

  AppModel appModel = getIt.get<AppModel>();

  TextEditingController nameCon = TextEditingController();
  TextEditingController schoolCon = TextEditingController();
  TextEditingController classCon = TextEditingController();
  TextEditingController fundsCon = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<DropDownItem> school = [];
  List<DropDownItem> alergy = [];

  List<DropDownItem> allgyList = [];

  initVal() {
    school = appModel.schoolModelList.map(
      (e) {
        return DropDownItem(e.name);
      },
    ).toList();

    alergy = appModel.alergy.map(
      (e) {
        return DropDownItem(e);
      },
    ).toList();
  }

  addChild() async {
    log(fundsCon.text);
    emit(LoadingState());
    if (formKey.currentState!.validate()) {
      if (appModel.userModel!.funds < double.parse(fundsCon.text)) {
        emit(ErrorState(
            msg: "لا تمتلك رصيد رصيدك : ${appModel.userModel!.funds}"));
        return;
      }
      late String schoolId;

      late SchoolModel schoolModel;

      for (var val in appModel.schoolModelList) {
        if (val.name == schoolCon.text) {
          schoolId = val.id;
          schoolModel = val;
        }
      }

      final res = await SuperMain().addChild(
          name: nameCon.text,
          userId: appModel.userModel!.id,
          allergy: allgyList.map(
            (e) {
              return e.name;
            },
          ).toList(),
          childClass: classCon.text,
          imgPath: "imgPath",
          schoolId: schoolId,
          funds: double.parse(fundsCon.text));

      final tempChild = ChildModel.fromJson(res);

      tempChild.schoolModel = schoolModel;

      appModel.userModel!.numberFollowers += 1;
      appModel.userModel!.childModelList.add(tempChild);

      emit(DoneAddState());
    } else {
      log("not good vaild");
      emit(NoLoadingState());
    }
  }
}
