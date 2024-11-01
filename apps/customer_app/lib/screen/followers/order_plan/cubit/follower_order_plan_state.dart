part of 'follower_order_plan_cubit.dart';

@immutable
sealed class FollowerOrderPlanState {}

final class FollowerOrderPlanInitial extends FollowerOrderPlanState {}


final class ErorrState extends FollowerOrderPlanState {
  final String msg;

  ErorrState({required this.msg});
}

final class DoneState extends FollowerOrderPlanState {}

final class LodingState extends FollowerOrderPlanState {}
