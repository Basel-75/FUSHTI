part of 'order_cubit.dart';

@immutable
sealed class OrderState {}

final class OrderInitial extends OrderState {}

final class ErorState extends OrderState {
  final String msg;

  ErorState({required this.msg});
}

final class DoneState extends OrderState {}
final class LodingState extends OrderState {}
final class QueUpdateState extends OrderState {}
