part of 'bottom_navigation_bloc.dart';

/// Event to change the selected tab in the bottom navigation bar.
@immutable
abstract class BottomNavigationEvent {}

/// Event to change the selected tab in the bottom navigation bar.
///
/// The [tabIndex] property represents the new index of the selected tab.
class TabChange extends BottomNavigationEvent {
  /// The new index of the selected tab.
  final int tabIndex;

  /// Creates a [TabChange] event.
  ///
  /// The [tabIndex] argument must not be null.
  TabChange({required this.tabIndex});
}
