part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class ChnageChildState extends HomeState {}

final class LoadingState extends HomeState {}

final class CheckState extends HomeState {}

final class CartThereState extends HomeState {}

final class DoneAddState extends HomeState {
  final String msg;

  DoneAddState({required this.msg});
}

final class SussesState extends HomeState {
  final String msg;

  SussesState({required this.msg});
}

final class ErrorState extends HomeState {
  final String msg;

  ErrorState({required this.msg});
}
