import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_firebase_app/bloc/authentication/authentication.dart';
import 'package:flutter_firebase_app/bloc/user_repository/user_repository.dart';
import 'package:meta/meta.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({@required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }

    if (event is SignInAnonymously) {
      yield AuthenticationLoading();
      final firebaseUser = await _userRepository.signInAnonymously();
      yield Authenticated(firebaseUser);
    }

    if (event is SignInWithEmail) {
      yield AuthenticationLoading();
      try {
        final firebaseUser = await _userRepository.signInWithEmailAndPassword(
            event.email, event.password);
        yield Authenticated(firebaseUser);
      } catch (error) {
        yield Unauthenticated();
      }
    }

    if (event is SignInWithGoogle) {
      yield AuthenticationLoading();
      final firebaseUser = await _userRepository.signInWithGoogle();
      yield Authenticated(firebaseUser);
    }

    if (event is SignUpWithEmail) {
      yield AuthenticationLoading();
      try {
        final firebaseUser = await _userRepository.signUpWithEmailAndPassword(
            event.username, event.email, event.password);
        yield Authenticated(firebaseUser);
      } catch (error) {
        yield Unauthenticated();
      }
    }

    if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final firebaseUser = await _userRepository.getCurrentUser();
      if (firebaseUser != null) {
        yield Authenticated(firebaseUser);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLogoutToState() async* {
    await _userRepository.signOut();
    yield Unauthenticated();
  }
}
