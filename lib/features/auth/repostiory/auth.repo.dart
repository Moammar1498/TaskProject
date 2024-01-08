import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/features/auth/model/user.dart';

class AuthRepository {
  Future<void> registerUser(UserModel user) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      User? remoteUser = userCredential.user;
      await remoteUser?.updateDisplayName("${user.firstName} ${user.lastName}");

      // Store additional user data in Cloud Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(remoteUser?.uid)
          .set({
        'firstName': user.firstName,
        'lastName': user.lastName,
        'phone': user.phone,
        'gender': '',
        'birthdate': '',
        'photoUrl': '',
      });
    } on SocketException {
      throw 'Please Check your internet';
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on SocketException {
      throw 'Please Check your internet';
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
