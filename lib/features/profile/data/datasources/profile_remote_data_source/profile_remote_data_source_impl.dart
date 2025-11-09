import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:taska/features/profile/data/datasources/profile_remote_data_source/profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  ProfileRemoteDataSourceImpl({required this.firebaseAuth});
  @override
  Future<void> changeAccountImage(File image) {
    // TODO: implement changeAccountImage
    throw UnimplementedError();
  }

  @override
  Future<void> changeAccountName(String name) async {
    await firebaseAuth.currentUser?.updateDisplayName(name);
    await firebaseAuth.currentUser?.reload();
  }

  @override
  Future<void> changeAccountPassword(
    String oldPassword,
    String newPassword,
  ) async {
    AuthCredential credential = EmailAuthProvider.credential(
      email: firebaseAuth.currentUser!.email!,
      password: oldPassword,
    );
    await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    await firebaseAuth.currentUser!.updatePassword(newPassword);
  }
}
