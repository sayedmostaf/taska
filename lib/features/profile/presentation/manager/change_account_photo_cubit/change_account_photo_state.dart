sealed class ChangeAccountPhotoState {}

final class ChangeAccountPhotoInitial extends ChangeAccountPhotoState {}

final class ChangeAccountPhotoLoading extends ChangeAccountPhotoState {}

final class ChangeAccountPhotoSuccess extends ChangeAccountPhotoState {}

final class ChangeAccountPhotoFailure extends ChangeAccountPhotoState {
  final String errMessage;

  ChangeAccountPhotoFailure({required this.errMessage});
}
