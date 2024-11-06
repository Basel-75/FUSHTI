part of 'plan_cubit.dart';

@immutable
sealed class PlanState {}

final class PlanInitial extends PlanState {}

final class PlanChangeState extends PlanState {
  final String msg;

  PlanChangeState({required this.msg});
}

final class LoadingState extends PlanState {}

final class NoLoadingState extends PlanState {}

final class ChildClickState extends PlanState {}

final class PlanClickState extends PlanState {}

final class DelItemState extends PlanState {}

final class NoInterState extends PlanState {}

final class ErrorPlanState extends PlanState {
  final String msg;

  ErrorPlanState({required this.msg});
}

final class ToCartState extends PlanState {}
