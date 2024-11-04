part of 'followers_profile_cubit.dart';

@immutable
sealed class FollowersProfileState {}

final class FollowersProfileInitial extends FollowersProfileState {}

final class LoadingState extends FollowersProfileState {}

final class AfterDelState extends FollowersProfileState {
  final String msg;

  AfterDelState({required this.msg});
}

final class SuccessState extends FollowersProfileState {
  final String msg;

  SuccessState({required this.msg});
}

final class SuccessUpdateImageState extends FollowersProfileState {
  final String msg;

  SuccessUpdateImageState({required this.msg});
}

final class ErrorUpdateImageState extends FollowersProfileState {
  final String msg;

  ErrorUpdateImageState({required this.msg});
}

final class ErrorState extends FollowersProfileState {
  final String msg;

  ErrorState({required this.msg});
}

class ImagePickedState extends FollowersProfileState {
  final File image;
  ImagePickedState(this.image);
}
