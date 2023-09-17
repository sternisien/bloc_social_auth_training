import 'package:bloc_social_auth_training/bloc/authentification/auth_bloc.dart';
import 'package:bloc_social_auth_training/bloc/authentification/events/auth_event_sign_out.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state.dart';
import 'package:bloc_social_auth_training/bloc/authentification/states/auth_state_logged.dart';
import 'package:bloc_social_auth_training/bloc/navigation_bar/events/on_tap_item_navbar_event.dart';
import 'package:bloc_social_auth_training/bloc/navigation_bar/navigation_bar_bloc.dart';
import 'package:bloc_social_auth_training/bloc/navigation_bar/states/nav_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late User? currentUser;
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: ((context, state) {
          if (state is AuthStateLogged) {
            currentUser = state.getCurrentUser();
          }
          return Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(currentUser?.displayName ?? "unknow user"),
                    TextButton(
                      onPressed: () {
                        context
                            .read<AuthBloc>()
                            .add(AuthEventSignOut(currentUser));
                      },
                      style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.lightBlueAccent),
                        shadowColor: MaterialStatePropertyAll(Colors.black),
                        elevation: MaterialStatePropertyAll(2.0),
                      ),
                      child: const Text("Sign Out From Google"),
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => NavigationBarBloc(),
        child: BlocBuilder<NavigationBarBloc, NavState>(
          builder: (context, state) {
            return BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.accessibility_new),
                  label: "test",
                ),
              ],
              onTap: (val) {
                context.read<NavigationBarBloc>().add(
                      OnTapItemNavbarEvent(currentIndexTap: val),
                    );
              },
              currentIndex: state.getCurrentIndex(),
            );
          },
        ),
      ),
    );
  }
}
