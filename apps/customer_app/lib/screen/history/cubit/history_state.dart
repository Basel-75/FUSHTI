part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

final class HistoryInitial extends HistoryState {}

final class ErorrState extends HistoryState {
  final String msg;

  ErorrState({required this.msg});
}

final class DoneState extends HistoryState {}

final class LodingState extends HistoryState {}
