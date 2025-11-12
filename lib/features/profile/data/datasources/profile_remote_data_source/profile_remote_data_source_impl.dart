import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taska/features/profile/data/datasources/profile_remote_data_source/profile_remote_data_source.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final SupabaseClient supabase;
  ProfileRemoteDataSourceImpl(
    this.firestore,
    this.supabase, {
    required this.firebaseAuth,
  });
  @override
  Future<void> changeAccountImage(File image) async {
    final uid = firebaseAuth.currentUser!.uid;
    final fileName =
        'users/$uid/profile_${DateTime.now().millisecondsSinceEpoch}.png';
    await supabase.storage.from('images').update(fileName, image);
    final imageUrl = supabase.storage.from('images').getPublicUrl(fileName);

    await firebaseAuth.currentUser!.updatePhotoURL(imageUrl);
    await firebaseAuth.currentUser!.reload();
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

  @override
  Future<void> deleteAccount(String? password) async {
    if (password == null) {
      await firebaseAuth.currentUser!.reauthenticateWithProvider(
        GoogleAuthProvider(),
      );
    } else {
      AuthCredential credential = EmailAuthProvider.credential(
        email: firebaseAuth.currentUser!.email!,
        password: password,
      );
      await firebaseAuth.currentUser!.reauthenticateWithCredential(credential);
    }
    for (String subCollectionName in ['categories', 'tasks', 'focus']) {
      CollectionReference subCollectionRef = firestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection(subCollectionName);
      QuerySnapshot subCollectionSnapshot = await subCollectionRef.get();
      for (DocumentSnapshot subCollectionDoc in subCollectionSnapshot.docs) {
        await subCollectionDoc.reference.delete();
      }
    }
    await firestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .delete();
    try {
      //TODO: remove image
    } catch (e) {}
    await firebaseAuth.currentUser!.delete();
  }
}
