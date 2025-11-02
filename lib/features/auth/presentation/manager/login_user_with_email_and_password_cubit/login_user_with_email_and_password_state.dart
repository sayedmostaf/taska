sealed class LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordInitial
    extends LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordLoading
    extends LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordSuccess
    extends LogInUserWithEmailAndPasswordState {}

final class LogInUserWithEmailAndPasswordFailure
    extends LogInUserWithEmailAndPasswordState {
  final String errMessage;

  LogInUserWithEmailAndPasswordFailure({required this.errMessage});
}
