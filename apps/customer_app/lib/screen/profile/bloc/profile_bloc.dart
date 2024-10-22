import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_all_pkg/data/model/app_model.dart';
import 'package:get_all_pkg/data/setup.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  AppModel appModel = getIt.get<AppModel>();
  String? userName = '';
  String? phoneNum = '';
  String? followersNum = '';
  String? planNum = '';
  String? funds = '';
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<GetUserInfoEvent>(getUserInfoMethod);
  }

  FutureOr<void> getUserInfoMethod(event, emit) {
    userName = appModel.userModel?.name;
    phoneNum = appModel.userModel?.phone;
    funds = appModel.userModel?.funds.toString();
    followersNum = appModel.userModel?.childModelList != null
        ? appModel.userModel?.childModelList.length.toString()
        : '0';
  }
}
