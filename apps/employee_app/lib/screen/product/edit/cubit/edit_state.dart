part of 'edit_cubit.dart';

@immutable
sealed class EditState {}

final class AddInitial extends EditState {}

final class LoadingState extends EditState {}

final class SussesState extends EditState {
  final String msg;

  SussesState({required this.msg});
}

final class ErrorState extends EditState {
  final String msg;

  ErrorState({required this.msg});
}

class ImagePickedState extends EditState {
  final File image;
  ImagePickedState(this.image);
}
