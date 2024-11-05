part of 'scan_cubit.dart';

@immutable
sealed class ScanState {}

final class ScanInitial extends ScanState {}

final class ErorState extends ScanState {
  final String msg;

  ErorState({required this.msg});
}

final class DoneState extends ScanState {}

final class LoadingState extends ScanState {}