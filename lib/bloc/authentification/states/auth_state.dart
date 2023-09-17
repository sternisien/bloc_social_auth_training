import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {
  final User? _currentUser;

  AuthState(User? user) : _currentUser = user;

  User? getCurrentUser() {
    return _currentUser;
  }
}
