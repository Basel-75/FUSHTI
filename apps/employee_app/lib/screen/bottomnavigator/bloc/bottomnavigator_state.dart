part of 'bottomnavigator_bloc.dart';

@immutable
sealed class BottomnavigatorState {}

final class BottomnavigatorInitial extends BottomnavigatorState {}

final class IndexChangeState extends BottomnavigatorState {
  final int index;

  IndexChangeState({required this.index});
}