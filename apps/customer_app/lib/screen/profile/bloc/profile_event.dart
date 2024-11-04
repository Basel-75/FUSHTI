part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetUserInfoEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {}

class PickImageEvent extends ProfileEvent {}

class UpdateImageEvent extends ProfileEvent {}

class PaymentEvent extends ProfileEvent {}

class SendMessagesEvent extends ProfileEvent {
  final String senderName, schoolId, content;

  SendMessagesEvent(
      {required this.senderName,
      required this.schoolId,
      required this.content});
}