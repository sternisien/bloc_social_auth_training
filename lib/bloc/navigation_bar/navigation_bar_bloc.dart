import 'package:bloc_social_auth_training/bloc/navigation_bar/events/on_tap_item_navbar_event.dart';
import 'package:bloc_social_auth_training/bloc/navigation_bar/states/nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBarBloc extends Bloc<OnTapItemNavbarEvent, NavState> {
  NavigationBarBloc() : super(NavState(currentIndex: 0)) {
    on<OnTapItemNavbarEvent>(
      (event, emit) => emit(
        NavState(
          currentIndex: event.getCurrentIndexTap(),
        ),
      ),
    );
  }
}
