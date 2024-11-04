part of 'feedback_cubit.dart';

@immutable
sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

final class LoadingState extends FeedbackState {}

final class SuccessState extends FeedbackState {}

final class ErrorState extends FeedbackState {
  final String msg;

  ErrorState({required this.msg});
}
