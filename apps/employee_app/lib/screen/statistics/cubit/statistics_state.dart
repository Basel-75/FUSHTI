part of 'statistics_cubit.dart';

@immutable
sealed class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}

final class ErrorState extends StatisticsState {
  final String msg;

  ErrorState({required this.msg});
}


final class DoneState extends StatisticsState {}

final class LoadingState extends StatisticsState {}
