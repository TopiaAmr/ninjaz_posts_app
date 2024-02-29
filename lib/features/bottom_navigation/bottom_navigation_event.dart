part of 'bottom_navigation_bloc.dart';

@immutable
abstract class BottomNavigationEvent {}

class TabChange extends BottomNavigationEvent {
  final int tabIndex;

  TabChange({required this.tabIndex});
}
