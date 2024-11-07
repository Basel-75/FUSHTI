part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetUserInfoEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {}

class PaymentEvent extends ProfileEvent {}

class CheckPaymentEvent extends ProfileEvent {
  final PaymentResponse paymentResponse;

  CheckPaymentEvent({required this.paymentResponse});
}

class SendMessagesEvent extends ProfileEvent {
  final String senderName, schoolId, content;

  SendMessagesEvent(
      {required this.senderName,
      required this.schoolId,
      required this.content});
}
