import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/features/auth/model/user.dart';

class AuthRepository {
  Future<User?> registerUser(UserModel user) async {
    User? remoteUser;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      remoteUser = userCredential.user;
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
    } on FirebaseAuthException catch (e) {
      debugPrint(' ${e.code} ${e.message}');
      if (e.code == 'email-already-in-use') {
        debugPrint(e.message);
        throw e.message.toString();
      } else if (e.code == 'invalid-email') {
        debugPrint(e.message);
        throw 'Email must be valid.';
      } else if (e.code == 'invalid-password') {
        throw 'Password must not be less than 6 ch';
      } else {
        throw 'Some error occurred from the server';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return remoteUser;
  }

  Future<User?> loginUser(String email, String password) async {
    User? user;
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      user = userCredential.user;
    } on SocketException {
      throw 'Please Check your internet';
    } on FirebaseAuthException catch (e) {
      debugPrint(' ${e.code} ${e.message}');
      if (e.code == 'user-not-found') {
        throw 'Email or Password wrong. please login again with correct email & password.';
      } else if (e.code == 'wrong-password') {
        throw 'Wrong password provided.';
      } else if (e.code == 'invalid-credential') {
        throw 'Incorrect email or password. please login with correct credentials or register your account.';
      } else if (e.code == 'invalid-email') {
        throw 'Please enter the valid email. abc@email.com';
      } else {
        throw 'Some error occurred from the server';
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return user;
  }
}
