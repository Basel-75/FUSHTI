import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/helper/check_intent.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AppModel appModel = getIt.get<AppModel>();
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController phoneNumController = TextEditingController(text: '');
  String? userName = '';
  String? phoneNum = '';
  String? followersNum = '';
  String? planNum = '';
  String? funds = '';
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetUserInfoEvent>(getUserInfoMethod);
    on<UpdateProfileEvent>(updateProfileMethod);
  }

  FutureOr<void> updateProfileMethod(event, emit) async {
    log('${usernameController.text}|${phoneNumController.text}');
    final inter = await CheckIntent().checkInternetConnection();
    if (inter) {
      await SuperMain().updateUserProfile(
          id: appModel.userModel!.id,
          name: usernameController.text.trim(),
          phone: phoneNumController.text.trim());
      emit(ProfileUpdatedState());
    } else {
      emit(ErrorState());
    }
    usernameController.clear();
    phoneNumController.clear();
  }

  FutureOr<void> getUserInfoMethod(event, emit) {
    userName = appModel.userModel?.name;
    phoneNum = appModel.userModel?.phone;
    funds = appModel.userModel?.funds.toString();
    followersNum = appModel.userModel?.childModelList != null
        ? appModel.userModel?.childModelList.length.toString()
        : '0';
    //get total plan number
    try {
      int count = 0;
      for (var element in appModel.userModel!.childModelList) {
        count += element.planList.length;
      }
      planNum = '$count';
    } catch (e) {
      planNum = '0';
    }
    emit(ProfileLoadedState(
        userName: userName,
        phoneNum: phoneNum,
        followersNum: followersNum,
        planNum: planNum,
        funds: funds));
  }
}
