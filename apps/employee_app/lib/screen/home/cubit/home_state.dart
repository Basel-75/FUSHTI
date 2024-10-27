part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingState extends HomeState {}

final class SuccessState extends HomeState {
  final String msg;

  SuccessState({required this.msg});
}

final class ErrorState extends HomeState {
  final String msg;

  ErrorState({required this.msg});
}
