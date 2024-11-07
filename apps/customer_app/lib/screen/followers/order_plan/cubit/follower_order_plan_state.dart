part of 'follower_order_plan_cubit.dart';

@immutable
sealed class FollowerOrderPlanState {}

final class FollowerOrderPlanInitial extends FollowerOrderPlanState {}

final class ErrorState extends FollowerOrderPlanState {
  final String msg;

  ErrorState({required this.msg});
}

final class DoneState extends FollowerOrderPlanState {}

final class LoadingState extends FollowerOrderPlanState {}
