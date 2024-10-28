part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ImagePickedState extends ProfileState {
  final File selectedImage;

  ImagePickedState({required this.selectedImage});
}

class ProfileLoadedState extends ProfileState {
  final String? userName;
  final String? phoneNum;
  final String? followersNum;
  final String? planNum;
  final String? funds;

  ProfileLoadedState({
    required this.userName,
    required this.phoneNum,
    required this.followersNum,
    required this.planNum,
    required this.funds,
  });
}

class ProfileUpdatedState extends ProfileState {}

class LoadingState extends ProfileState {}

class SussesState extends ProfileState {
  final String msg;

  SussesState({required this.msg});
}

class ErrorState extends ProfileState {
  final String msg;

  ErrorState({required this.msg});
}
