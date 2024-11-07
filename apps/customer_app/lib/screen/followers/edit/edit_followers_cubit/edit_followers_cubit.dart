import 'package:bloc/bloc.dart';
import 'package:customer_app/component/drop_down_item.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/model/child_model.dart';
import 'package:get_all_pkg/data/model/school_model.dart';
import 'package:get_all_pkg/data/setup.dart';

part 'edit_followers_state.dart';

class EditFollowersCubit extends Cubit<EditFollowersState> {
  EditFollowersCubit({required this.childModel})
      : super(EditFollowersInitial());

  AppModel appModel = getIt.get<AppModel>();

  TextEditingController nameCon = TextEditingController();
  TextEditingController schoolCon = TextEditingController();
  TextEditingController classCon = TextEditingController();
  TextEditingController fundsCon = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<DropDownItem> school = [];
  DropDownItem? initSchoolDrop;
  List<DropDownItem> allergy = [];
  List<DropDownItem> initAllergy = [];

  List<DropDownItem> allgyList = [];

  final ChildModel childModel;

  initVal() {
    school = appModel.schoolModelList.map(
      (e) {
        return DropDownItem(e.name);
      },
    ).toList();

    allergy = appModel.alergy.map(
      (e) {
        return DropDownItem(e);
      },
    ).toList();
    nameCon.text = childModel.name;
    classCon.text = childModel.studentClass;
    schoolCon.text = childModel.schoolModel.name;

    initSchoolDrop = school.firstWhere(
      (item) => item.name == childModel.schoolModel.name,
    );

    initAllergy = childModel.allergy
        .map((e) => allergy.firstWhere((item) => item.name == e))
        .toList();

    allgyList = List.from(initAllergy);
  }

  editChild() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState());
      late String schoolId;
      late SchoolModel schoolModel;

      for (var val in appModel.schoolModelList) {
        if (val.name == schoolCon.text) {
          schoolId = val.id;
          schoolModel = val;
        }
      }
      //Update in DB
      await SuperMain().editChild(
        name: nameCon.text,
        id: childModel.id,
        allergy: allgyList.map(
          (e) {
            return e.name;
          },
        ).toList(),
        childClass: classCon.text,
        schoolId: schoolId,
      );
      //Update locale
      try {
        //sure not empty
        if (appModel.userModel!.childModelList.isNotEmpty) {
          for (var i = 0; i < appModel.userModel!.childModelList.length; i++) {
            //find correct child
            if (appModel.userModel?.childModelList[i].id == childModel.id) {
              //update
              appModel.userModel?.childModelList[i].name = nameCon.text.trim();
              appModel.userModel?.childModelList[i].studentClass =
                  classCon.text.trim();
              appModel.userModel?.childModelList[i].schoolId = schoolId;

              appModel.userModel?.childModelList[i].allergy = allgyList.map(
                (e) {
                  return e.name;
                },
              ).toList();

              appModel.userModel?.childModelList[i].schoolModel = schoolModel;
            }
          }
        }
      } catch (e) {}
      emit(SuccessEditState());
    } else {}
  }
}
