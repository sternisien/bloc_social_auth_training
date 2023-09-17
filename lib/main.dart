import 'package:bloc_social_auth_training/bloc/authentification/auth_bloc.dart';
import 'package:bloc_social_auth_training/bloc/authentification/events/auth_event_check_already_sign_in.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state_logged_out.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state_uninitialize.dart';
import 'package:bloc_social_auth_training/firebase_options.dart';
import 'package:bloc_social_auth_training/services/auth_service.dart';
import 'package:bloc_social_auth_training/views/login.dart';
import 'package:bloc_social_auth_training/views/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(AuthService()),
        child: Home(),
      ),
    ),
  );
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(AuthEventCheckAlreadySignIn());
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthStateUninitialize || state is AuthStateLoggedOut) {
        return Login();
      } else {
        return Welcome();
      }
    });
  }
}
