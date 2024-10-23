part of 'followers_profile_cubit.dart';

@immutable
sealed class FollowersProfileState {}

final class FollowersProfileInitial extends FollowersProfileState {}

final class LoadingState extends FollowersProfileState {}

final class SuccessState extends FollowersProfileState {
  final String msg;

  SuccessState({required this.msg});
}

final class ErrorState extends FollowersProfileState {
  final String msg;

  ErrorState({required this.msg});
}
