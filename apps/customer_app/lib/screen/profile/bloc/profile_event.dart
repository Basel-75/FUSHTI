part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetUserInfoEvent extends ProfileEvent{}
