part of 'child_serch_cubit.dart';

@immutable
sealed class ChildSerchState {}

final class ChildSerchInitial extends ChildSerchState {}
final class LoadingState extends ChildSerchState {}
final class SuccessState extends ChildSerchState {}
final class ErrorState extends ChildSerchState {

  final String msg;

  ErrorState({required this.msg});
}
