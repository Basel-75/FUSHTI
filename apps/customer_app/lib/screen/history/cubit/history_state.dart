part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class ErrorState extends HistoryState {
  final String msg;

  ErrorState({required this.msg});
}

final class DoneState extends HistoryState {}

final class LoadingState extends HistoryState {}
