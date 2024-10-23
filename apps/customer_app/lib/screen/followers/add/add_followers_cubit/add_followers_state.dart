part of 'add_followers_cubit.dart';

@immutable
sealed class AddFollowersState {}

final class AddFollowersInitial extends AddFollowersState {}

final class DoenAddState extends AddFollowersState {}
final class NoLodingState extends AddFollowersState {}

final class LodingState extends AddFollowersState {}

final class ErorrState extends AddFollowersState {
  final String msg;

  ErorrState({required this.msg});
}
