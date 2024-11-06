part of 'order_cart_cubit.dart';

@immutable
sealed class OrderCartState {}

final class OrderCartInitial extends OrderCartState {}

final class ChangeQueState extends OrderCartState {}

final class DoneState extends OrderCartState {}

final class LoadingState extends OrderCartState {}

final class ErrorState extends OrderCartState {
  final String msg;

  ErrorState({required this.msg});
}
