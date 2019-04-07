import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_app/bloc/authentication/authentication.dart';
import 'package:flutter_firebase_app/bloc/user_repository/user_repository.dart';
import 'package:flutter_firebase_app/constants/routes.dart';
import 'package:flutter_firebase_app/screens/auth/auth_screen.dart';
import 'package:flutter_firebase_app/screens/auth/splash_screen.dart';
import 'package:flutter_firebase_app/screens/home/about.dart';
import 'package:flutter_firebase_app/screens/home/contact.dart';
import 'package:flutter_firebase_app/screens/home/home_screen.dart';
import 'package:flutter_firebase_app/screens/home/profile_screen.dart';
import 'package:flutter_firebase_app/screens/home/settings_screen.dart';
import 'package:flutter_firebase_app/simple_bloc_delegate.dart';

main() {
  BlocSupervisor().delegate = SimpleBlocDelegate();
  runApp(App());
}

class App extends StatefulWidget {
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final UserRepository _userRepository = UserRepository();
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authenticationBloc,
      child: MaterialApp(
        home: BlocBuilder(
          bloc: _authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is Unauthenticated || state is AuthenticationLoading) {
              return AuthScreen(authBloc: _authenticationBloc);
            }
            if (state is Authenticated) {
              return HomeScreen(firebaseUser: state.firebaseUser);
            }
          },
        ),
        routes: <String, WidgetBuilder>{
          Routes.settings: (BuildContext context) => SettingsScreen(),
          Routes.profile: (BuildContext context) => ProfileScreen(),
          Routes.about: (BuildContext context) => AboutPage(),
          '/contact': (BuildContext context) => ContactPage(),
        },
      ),
    );
  }

  @override
  void dispose() {
    _authenticationBloc.dispose();
    super.dispose();
  }
}
