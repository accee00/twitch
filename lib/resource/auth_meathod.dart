import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitch/models/user.dart' as model;
import 'package:twitch/provider/user_provider.dart';
import 'package:twitch/utils/snackbar_utils.dart';

class AuthMethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('users');

  Future<Map<String, dynamic>?> getCurrentUser(String? uid) async {
    if (uid != null) {
      final snap = await _userRef.doc(uid).get();
      return snap.data() as Map<String, dynamic>?;
    }
    return null;
  }

  Future<bool> signUpUser(
    BuildContext context,
    String email,
    String userName,
    String password,
  ) async {
    bool result = false;

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (cred.user != null) {
        final model.User user = model.User(
          uid: cred.user!.uid,
          username: userName.trim(),
          email: email.trim(),
        );
        await _userRef.doc(cred.user!.uid).set(user.toMap());

        Provider.of<UserProvider>(context, listen: false).setUser(user);
        result = true;
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackbar(context, e.message ?? 'An error occurred.');
      }
    }
    return result;
  }

  Future<bool> logInUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    bool result = false;

    try {
      UserCredential cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (cred.user != null) {
        final snap = await _userRef.doc(cred.user!.uid).get();
        final userData = snap.data() as Map<String, dynamic>?;
        if (userData != null) {
          final model.User user = model.User.fromMap(userData);
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          result = true;
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        showSnackbar(context, e.message ?? 'An error occurred.');
      }
    }
    return result;
  }
}
