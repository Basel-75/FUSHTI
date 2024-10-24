part of 'edit_followers_cubit.dart';

@immutable
sealed class EditFollowersState {}

final class EditFollowersInitial extends EditFollowersState {}

final class SuccessEditState extends EditFollowersState {}

final class UnLoadingState extends EditFollowersState {}

final class LoadingState extends EditFollowersState {}

final class ErrorState extends EditFollowersState {
  final String msg;

  ErrorState({required this.msg});
}
