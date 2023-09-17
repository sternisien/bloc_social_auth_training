import 'package:bloc_social_auth_training/bloc/authentification/auth_bloc.dart';
import 'package:bloc_social_auth_training/bloc/authentification/events/auth_event_sign_in.dart';
import 'package:bloc_social_auth_training/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String currentUser = "empty";
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Auth Training"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                const Size(60.0, 30.0),
              ),
            ),
            onPressed: () async {
              context.read<AuthBloc>().add(AuthEventSignIn());
            },
            child: Text("google"),
          ),
        ],
      ),
    );
  }
}
