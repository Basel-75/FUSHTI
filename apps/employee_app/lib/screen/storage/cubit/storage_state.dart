part of 'storage_cubit.dart';

@immutable
sealed class StorageState {}

final class StorageInitial extends StorageState {}

final class ErrorState extends StorageState {
  final String msg;

  ErrorState({required this.msg});
}

final class DoneState extends StorageState {}
final class LoadingState extends StorageState {}
