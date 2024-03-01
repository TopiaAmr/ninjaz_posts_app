part of 'bottom_navigation_bloc.dart';

/// The current state of the bottom navigation bar.
@immutable
abstract class BottomNavigationState {
  /// The index of the currently selected tab.
  final int tabIndex;

  /// Creates a [BottomNavigationState] with the given [tabIndex].
  const BottomNavigationState({required this.tabIndex});
}

/// The initial state of the bottom navigation bar when it is first created.
///
/// This represents the state when the user has selected the landing page.
class LandingPageInitial extends BottomNavigationState {
  /// Creates a [LandingPageInitial] with the given [tabIndex].
  const LandingPageInitial({required super.tabIndex});
}
