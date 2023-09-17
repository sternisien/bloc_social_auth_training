import 'package:bloc_social_auth_training/bloc/authentification/events/auth_event.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthEventSignOut extends AuthEvent {
  late User? _currentUser;

  AuthEventSignOut(User? currentUser) {
    _currentUser = currentUser;
  }

  User? getCurrentUser() {
    return _currentUser;
  }
}
