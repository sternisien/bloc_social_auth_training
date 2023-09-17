import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthStateLogged extends AuthState {
  AuthStateLogged({required User? user}) : super(user);
}
