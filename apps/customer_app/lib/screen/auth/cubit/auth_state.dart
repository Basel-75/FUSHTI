part of 'auth_cubit.dart';

@immutable
sealed class AuthStatee {}

final class AuthInitial extends AuthStatee {}

final class SuccessState extends AuthStatee {}

final class ErrorState extends AuthStatee {
  final String msg;

  ErrorState({required this.msg});
}

final class LoadingState extends AuthStatee {}

final class NoLoadingState extends AuthStatee {}
