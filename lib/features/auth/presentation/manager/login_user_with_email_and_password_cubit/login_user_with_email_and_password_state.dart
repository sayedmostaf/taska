import 'package:firebase_auth/firebase_auth.dart';

sealed class LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordInitial
    extends LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordLoading
    extends LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordSuccess
    extends LogInUserWithEmailAndPasswordState {
  final UserCredential user;
  LogInUserWithEmailAndPasswordSuccess({required this.user});
}

final class LogInUserWithEmailAndPasswordFailure
    extends LogInUserWithEmailAndPasswordState {
  final String errMessage;

  LogInUserWithEmailAndPasswordFailure({required this.errMessage});
}
