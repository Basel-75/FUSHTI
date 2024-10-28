import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:get_all_pkg/helper/check_intent.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AppModel appModel = getIt.get<AppModel>();
  File? selectedImage;
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
    on<ProfileEvent>(updateImage);
    on<GetUserInfoEvent>(getUserInfoMethod);
    on<UpdateProfileEvent>(updateProfileMethod);
    on<PickImageEvent>(pickImage);
  }

  FutureOr<void> updateImage(event, emit) async {
    emit(LoadingState());
    //Update in DB
    try {
      if (selectedImage == null) {
        emit(ErrorState(msg: 'No image selected'));
        return;
      }

      final imageUrl = await SuperMain().uploadImage(imageFile: selectedImage!);

      final newProduct = await SuperMain().updateUserProfileImage(
          id: appModel.userModel!.id, imageUrl: imageUrl);
      //Update Locale
      appModel.userModel!.imageUrl = imageUrl;
      emit(SussesState(msg: 'تمت تحديث الصورة بنجاح'));
    } catch (e) {
      emit(ErrorState(msg: 'حدث خطأ ما يرجى المحاولة مرة اخرى'));
    }
  }

  FutureOr<void> pickImage(event, emit) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      emit(ImagePickedState(selectedImage: selectedImage!));
    } else {
      emit(ErrorState(msg: 'لم يتم اختيار صور للمنتج'));
    }
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
      appModel.userModel!.name = usernameController.text.trim();
      appModel.userModel!.phone = phoneNumController.text.trim();

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
