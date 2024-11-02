part of 'order_cart_cubit.dart';

@immutable
sealed class OrderCartState {}

final class OrderCartInitial extends OrderCartState {}
final class ChangeQueState extends OrderCartState {}

final class DoneState extends OrderCartState {}
final class LodingState extends OrderCartState {}

final class ErorrState extends OrderCartState {
  final String msg;

  ErorrState({required this.msg});
}



