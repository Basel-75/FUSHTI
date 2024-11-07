part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class ErrorState extends OrderState {
  final String msg;

  ErrorState({required this.msg});
}

final class DoneState extends OrderState {}

final class SuccessState extends OrderState {
  final String msg;

  SuccessState({required this.msg});
}

final class LoadingState extends OrderState {}

final class NoLoadingState extends OrderState {}

final class QueUpdateState extends OrderState {}
