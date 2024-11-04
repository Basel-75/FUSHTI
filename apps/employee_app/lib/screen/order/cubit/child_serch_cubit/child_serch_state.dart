part of 'child_serch_cubit.dart';

@immutable
sealed class ChildSearchState {}

final class ChildSerchInitial extends ChildSearchState {}
final class LoadingState extends ChildSearchState {}
final class SuccessState extends ChildSearchState {}
final class ErrorState extends ChildSearchState {

  final String msg;

  ErrorState({required this.msg});
}
