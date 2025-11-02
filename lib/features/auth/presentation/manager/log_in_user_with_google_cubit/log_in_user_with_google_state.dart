sealed class LogInUserWithGoogleState {}

final class LogInUserWithGoogleInitial extends LogInUserWithGoogleState {}

final class LogInUserWithGoogleLoading extends LogInUserWithGoogleState {}

final class LogInUserWithGoogleSuccess extends LogInUserWithGoogleState {}

final class LogInUserWithGoogleFailure extends LogInUserWithGoogleState {
  final String errMessage;

  LogInUserWithGoogleFailure({required this.errMessage});
}
