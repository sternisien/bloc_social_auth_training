import 'package:bloc_social_auth_training/bloc/authentification/events/auth_event_check_already_sign_in.dart';
import 'package:bloc_social_auth_training/bloc/authentification/events/auth_event_sign_in.dart';
import 'package:bloc_social_auth_training/bloc/authentification/events/auth_event_sign_out.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state_logged.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state_logged_out.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state_uninitialize.dart';
import 'package:bloc_social_auth_training/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'events/auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthService authService) : super(AuthStateUninitialize()) {
    on<AuthEventCheckAlreadySignIn>((event, emit) => {
          if (authService.isSignInWithFirebase())
            {emit(AuthStateLogged(user: authService.getCurrentUser()))}
        });
    on<AuthEventSignIn>((event, emit) async {
      final GoogleSignInAuthentication googleAuthenticationAccount =
          await authService.signInWithGoogle();
      await authService.signInToFirestore(
          googleSignInAuthentication: googleAuthenticationAccount);
      emit(AuthStateLogged(user: FirebaseAuth.instance.currentUser));
    });

    on<AuthEventSignOut>((event, emit) {
      try {
        authService.signOutFromFirebase(event.getCurrentUser());
      } catch (e) {}
      emit(AuthStateLoggedOut());
    });
  }
}
