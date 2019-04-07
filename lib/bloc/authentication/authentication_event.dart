import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class SignInAnonymously extends AuthenticationEvent {
  @override
  String toString() => 'SignInAnonymously';
}

class SignInWithGoogle extends AuthenticationEvent {
  @override
  String toString() => 'SignInWithGoogle';
}

class SignInWithEmail extends AuthenticationEvent {
  final String email;
  final String password;

  SignInWithEmail({
    @required this.email,
    @required this.password,
  }) : super([email, password]);

  @override
  String toString() => 'SignInWithEmail { email: $email, password: $password }';
}

class SignUpWithEmail extends AuthenticationEvent {
  final String username;
  final String email;
  final String password;

  SignUpWithEmail({
    @required this.username,
    @required this.email,
    @required this.password,
  }) : super([username, email, password]);

  @override
  String toString() =>
      'SignUpWithEmail { username: $username, email: $email, password: $password }';
}

class Logout extends AuthenticationEvent {
  @override
  String toString() => 'Logout';
}
