part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingState extends HomeState {
  final bool shouldRefresh;

  LoadingState({this.shouldRefresh = false});
}

final class SuccessState extends HomeState {
  final String msg;
  final bool shouldRefresh;
  SuccessState({required this.msg, this.shouldRefresh = false});
}

final class ErrorState extends HomeState {
  final String msg;

  ErrorState({required this.msg});
}
