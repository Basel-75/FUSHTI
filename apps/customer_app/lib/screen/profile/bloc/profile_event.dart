part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetUserInfoEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {}

class PickImageEvent extends ProfileEvent {}

class UpdateImageEvent extends ProfileEvent {}
