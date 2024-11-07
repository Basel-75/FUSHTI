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

class ProfileUpdatedState extends ProfileState {}

class LoadingState extends ProfileState {}

class SussesUpdateFundsState extends ProfileState {
  final String msg;

  SussesUpdateFundsState({required this.msg});
}

class SussesState extends ProfileState {
  final String msg;

  SussesState({required this.msg});
}

class SussesPayState extends ProfileState {
  final PaymentConfig paymentConfig;

  SussesPayState({required this.paymentConfig});
}

class ErrorState extends ProfileState {
  final String msg;

  ErrorState({required this.msg});
}
