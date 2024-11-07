part of 'bottomnavigator_bloc.dart';

@immutable
sealed class BottomnavigatorEvent {}

class NavigatorBetweenScreenEvent extends BottomnavigatorEvent {
  final int selectedIndex;

  NavigatorBetweenScreenEvent({required this.selectedIndex});
}