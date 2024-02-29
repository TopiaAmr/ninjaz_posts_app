import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(const LandingPageInitial(tabIndex: 0)) {
    on<BottomNavigationEvent>((event, emit) {
      if (event is TabChange) {
        print(event.tabIndex);
        emit(LandingPageInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
