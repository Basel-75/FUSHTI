import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:database_meth/database/super_main.dart';
import 'package:flutter/material.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:get_all_pkg/get_all_pkg.dart';
import 'package:get_all_pkg/helper/check_intent.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AppModel appModel = getIt.get<AppModel>();
  File? selectedImage;
  TextEditingController usernameController =
      TextEditingController(text: 'باسل العلوي');
  TextEditingController phoneNumController =
      TextEditingController(text: '0512345678');
  TextEditingController amountController = TextEditingController(text: '20');
  TextEditingController? messageController = TextEditingController();
  String? userName = '';
  String? phoneNum = '';
  String? followersNum = '';
  String? planNum = '';
  String? funds = '';
  String? schoolName = '';
  String? schoolId = '';
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<CheckPaymentEvent>(checkPayment);
    on<PaymentEvent>(paymentConfig);
    on<SendMessagesEvent>(sendMessages);

    on<GetUserInfoEvent>(getUserInfoMethod);
    on<UpdateProfileEvent>(updateProfileMethod);
  }

  FutureOr<void> checkPayment(CheckPaymentEvent event, emit) async {
    if (event.paymentResponse.status == PaymentStatus.paid) {
      try {
        //Update in DB
        await SuperMain().updateFunds(
            userId: '${getIt.get<AppModel>().userModel?.id}',
            oldFund: appModel.userModel!.funds.toDouble(),
            funds: double.parse(amountController.text.trim()));
        //Update locale
        appModel.userModel?.funds += num.parse(amountController.text.trim());
        funds = appModel.userModel?.funds.toString();
        emit(SussesUpdateFundsState(msg: 'تم شحن المحفظة بنجاح'));
      } catch (e) {
        emit(ErrorState(msg: 'حصل خطأ ما يرجى المحاولة لاحقا'));
      }
      emit(ErrorState(msg: 'تعذر شحن المحفظة يرجى المحاولة لاحقا'));
    }
  }

  FutureOr<void> paymentConfig(PaymentEvent event, emit) async {
    emit(LoadingState());
    try {
      final paymentConfig = await moyserPay(
          priceTotal: double.parse(amountController.text.trim()));
      emit(SussesPayState(paymentConfig: paymentConfig!));
    } catch (e) {
      emit(ErrorState(msg: 'حصل خطأ ما يرجى المحاولة لاحقا'));
    }
  }

  FutureOr<void> sendMessages(SendMessagesEvent event, emit) async {
    emit(LoadingState());
    try {
      if (event.senderName.isEmpty || event.content.isEmpty) {
        emit(ErrorState(msg: 'حصل خطأ ما يرجى اعادة المحاولة لاحقا'));
      } else {
        for (var element in appModel.schoolModelList) {
          if (element.name == schoolName) {
            schoolId = element.id;
          }
        }
        await SuperMain().sendSuggestion(
            senderName: event.senderName,
            content: event.content,
            schoolId: event.schoolId);
        emit(SussesState(msg: 'شكرا لك تم الارسال بنجاح'));
        messageController?.clear();
        schoolName = '';
      }
    } catch (e) {
      emit(ErrorState(msg: 'حصل خطأ ما يرجى اعادة المحاولة لاحقا'));
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
