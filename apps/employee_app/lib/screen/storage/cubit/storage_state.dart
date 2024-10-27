part of 'storage_cubit.dart';

@immutable
sealed class StorageState {}

final class StorageInitial extends StorageState {}

final class ErorState extends StorageState {
  final String msg;

  ErorState({required this.msg});
}

final class DoneState extends StorageState {}
final class LodingState extends StorageState {}
