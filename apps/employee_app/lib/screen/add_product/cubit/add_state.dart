part of 'add_cubit.dart';

@immutable
sealed class AddState {}

final class AddInitial extends AddState {}

final class LoadingState extends AddState {}

final class SussesState extends AddState {
  final String msg;

  SussesState({required this.msg});
}

final class ErrorState extends AddState {
  final String msg;

  ErrorState({required this.msg});
}
