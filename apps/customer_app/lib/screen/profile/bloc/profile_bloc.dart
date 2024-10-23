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
  TextEditingController usernameController =
      TextEditingController(text: 'باسل العلوي');
  TextEditingController phoneNumController =
      TextEditingController(text: '0512345678');
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
      emit(LoadingState());
      //update in DB
      SuperMain().updateUserProfile(
          id: appModel.userModel!.id,
          name: usernameController.text.trim(),
          phone: phoneNumController.text.trim());
      // update model locale
      // appModel.userModel = appModel.userModel?.copyWith(
      //     name: usernameController.text.trim(),
      //     phone: phoneNumController.text.trim());
      log('${appModel.userModel?.toJson()}0');
      appModel.userModel=await SuperMain().getUser(id: appModel.userModel!.id);
      log('${SuperMain().getUser(id: appModel.userModel!.id)}1');
      log('${appModel.userModel?.toJson()}2');
      log('${appModel.schoolModelList.first.toJson()}3');
      log('${appModel.userModel?.childModelList.first.toJson()}4');
      emit(ProfileUpdatedState());
    } else {
      emit(ErrorState(msg: 'هناك خطأ يرجى اعادة المحاولة لاحقا'));
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
