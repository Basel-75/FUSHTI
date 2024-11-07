part of 'plan_cart_cubit.dart';

@immutable
sealed class PlanCartState {}

final class PlanCartInitial extends PlanCartState {}

final class QueChangeState extends PlanCartState {}

final class DateChangeState extends PlanCartState {}

final class ErrorState extends PlanCartState {
  final String msg;

  ErrorState({required this.msg});
}

final class DoneState extends PlanCartState {}

final class LoadingState extends PlanCartState {}
