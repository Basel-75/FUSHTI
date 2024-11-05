part of 'add_followers_cubit.dart';

@immutable
sealed class AddFollowersState {}

final class AddFollowersInitial extends AddFollowersState {}

final class DoneAddState extends AddFollowersState {}

final class NoLoadingState extends AddFollowersState {}

final class LoadingState extends AddFollowersState {}

final class ErrorState extends AddFollowersState {
  final String msg;

  ErrorState({required this.msg});
}
