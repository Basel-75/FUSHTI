import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:customer_app/component/drop_down_item.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'add_followers_state.dart';

class AddFollowersCubit extends Cubit<AddFollowersState> {
  AddFollowersCubit() : super(AddFollowersInitial());

  TextEditingController nameCon = TextEditingController();
  TextEditingController schoolCon = TextEditingController();
  TextEditingController classCon = TextEditingController();
  TextEditingController fundsCon = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  List<DropDownItem> allgyList = [];

  addChild() {
    if (formKey.currentState!.validate()) {
      log("very good vaild");
    }else{
      log("not good vaild");
    }
  }
}
