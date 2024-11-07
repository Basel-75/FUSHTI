part of 'restrictions_cubit.dart';

@immutable
sealed class RestrictionsState {}

final class RestrictionsInitial extends RestrictionsState {}

final class LoadingState extends RestrictionsState {}

final class ErrorState extends RestrictionsState {
  final String msg;

  ErrorState({required this.msg});
}

final class SuccessDeleteState extends RestrictionsState {
  final String msg;

  SuccessDeleteState({required this.msg});
}
