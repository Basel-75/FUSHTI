import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/component/drop_down_item.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'edit_followers_state.dart';

class EditFollowersCubit extends Cubit<EditFollowersState> {
  EditFollowersCubit() : super(EditFollowersInitial());

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

  editChild({required String childId}) async {
    log("${fundsCon.text}");
    emit(LoadingState());
    if (formKey.currentState!.validate()) {
      late String schoolId;

      for (var val in appModel.schoolModelList) {
        if (val.name == schoolCon.text) {
          schoolId = val.id;
        }
      }
      //Update in DB
      await SuperMain().editChild(
          name: nameCon.text,
          id: childId,
          allergy: allgyList.map(
            (e) {
              return e.name;
            },
          ).toList(),
          childClass: classCon.text,
          schoolId: schoolId,
          funds: double.parse(fundsCon.text));
      //Update locale
      try {
        //sure not empty
        if (appModel.userModel!.childModelList.isNotEmpty) {
          for (var i = 0; i < appModel.userModel!.childModelList.length; i++) {
            //find correct child
            if (appModel.userModel?.childModelList[i].id == childId) {
              //update
              appModel.userModel?.childModelList[i].name = nameCon.text.trim();
              appModel.userModel?.childModelList[i].studentClass =
                  classCon.text.trim();
              appModel.userModel?.childModelList[i].schoolId = schoolId;

              appModel.userModel?.childModelList[i].funds =
                  double.parse(fundsCon.text);
              appModel.userModel?.childModelList[i].allergy = allgyList.map(
                (e) {
                  return e.name;
                },
              ).toList();
              //to make sure
              log('${appModel.userModel?.childModelList[i].toJson()}');
              log('${appModel.userModel?.childModelList[i].id}|$childId');
            }
          }
        }
      } catch (e) {
        log('$e');
      }
      emit(SuccessEditState());
    } else {
      log("حدث خطأ");
      emit(UnLoadingState());
    }
  }
}
