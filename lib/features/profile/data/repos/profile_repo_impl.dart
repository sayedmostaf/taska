import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:taska/core/errors/failures.dart';
import 'package:taska/core/errors/firebase_auth_failure.dart';
import 'package:taska/core/notifications/local_notification.dart';
import 'package:taska/core/utils/strings_manager.dart';
import 'package:taska/features/profile/data/datasources/profile_local_data_source/profile_local_data_source.dart';
import 'package:taska/features/profile/data/datasources/profile_remote_data_source/profile_remote_data_source.dart';
import 'package:taska/features/profile/domain/repos/profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDataSource profileLocalDataSource;
  ProfileRepoImpl({
    required this.profileLocalDataSource,
    required this.profileRemoteDataSource,
  });
  @override
  Future<Either<Failure, void>> changeAccountImage(File image) {
    // TODO: implement changeAccountImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> changeAccountName(String name) async {
    try {
      await profileRemoteDataSource.changeAccountName(name);
      return right(null);
    } catch (e) {
      return left(Failure(message: StringsManager.operationNotAllowed.tr()));
    }
  }

  @override
  Future<Either<Failure, void>> changeAccountPassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      await profileRemoteDataSource.changeAccountPassword(
        oldPassword,
        newPassword,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return left(Failure(message: StringsManager.operationNotAllowed.tr()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount(String? password) async {
    try {
      await profileLocalDataSource.deleteAccount();
      await profileRemoteDataSource.deleteAccount(password);
      LocalNotification.cancelAllNotifications();
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthFailure.fromFirebaseAuthException(e));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
