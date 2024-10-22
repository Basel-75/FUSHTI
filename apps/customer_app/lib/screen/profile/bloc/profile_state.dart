part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String? userName;
  final String? phoneNum;
  final String? followersNum;
  final String? planNum;
  final String? funds;

  ProfileLoadedState({
    required this.userName,
    required this.phoneNum,
    required this.followersNum,
    required this.planNum,
    required this.funds,
  });
}