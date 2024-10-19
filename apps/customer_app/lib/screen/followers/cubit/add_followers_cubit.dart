import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/component/drop_down_item.dart';
import 'package:flutter/widgets.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

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

  List<DropDownItem> allgyList = [];

  initVal() {
    school = appModel.schoolModelList.map(
      (e) {
        return DropDownItem(e.name);
      },
    ).toList();
  }

  addChild() {
    if (formKey.currentState!.validate()) {
      log("very good vaild");

      
    } else {
      log("not good vaild");
    }
  }
}
