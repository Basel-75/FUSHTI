part of 'edit_followers_cubit.dart';

@immutable
sealed class EditFollowersState {}

final class EditFollowersInitial extends EditFollowersState {}

final class DoenAddState extends EditFollowersState {}

final class NoLodingState extends EditFollowersState {}

final class LodingState extends EditFollowersState {}

final class ErorrState extends EditFollowersState {
  final String msg;

  ErorrState({required this.msg});
}
