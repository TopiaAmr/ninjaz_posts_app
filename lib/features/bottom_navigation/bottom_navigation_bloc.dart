import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

/// Bottom navigation bar bloc.
///
/// This bloc manages the state of the bottom navigation bar. It is responsible
/// for handling events from the [BottomNavigationBar] and emitting new states
/// based on those events.
class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  /// Creates a [BottomNavigationBloc].
  BottomNavigationBloc() : super(const LandingPageInitial(tabIndex: 0)) {
    on<BottomNavigationEvent>((event, emit) {
      /// Handles a [TabChange] event and updates the state of the bloc with the
      /// new tab index.
      if (event is TabChange) {
        print(event.tabIndex);
        emit(LandingPageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
