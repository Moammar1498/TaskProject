import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/features/auth/model/user.dart';
import 'package:taskproject/features/profile/model/family_member.model.dart';

class ProfileRepository {
  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      var doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      return doc.data();
    } on SocketException {
      throw 'Please Check your internet';
    } catch (e) {
      debugPrint("Error retrieving user details: $e");
      return null;
    }
  }

  Future<void> updateUserDetails(UserModel userModel) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      currentUser?.updateEmail(userModel.email);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .update({
        'firstName': userModel.firstName,
        'lastName': userModel.lastName,
        'phone': userModel.phone,
        'gender': userModel.gender,
        'birthdate': userModel.birthdate,
        'photoUrl': userModel.photoUrl
      });
    } on SocketException {
      throw 'Please Check your internet';
    } catch (e) {
      debugPrint("Error updating user details: $e");
    }
  }

  Future<void> addFamilyMember(FamilyMember familyMember) async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('familyMembers').add({
        'userId': FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser?.uid),
        'fullName': familyMember.fullName,
        'relation': familyMember.relation,
        'phone': familyMember.phone,
        'birthdate': familyMember.birthdate,
        'gender': familyMember.gender,
        'photoUrl': familyMember.photoUrl
      });
    } on SocketException {
      throw 'Please Check your internet';
    } catch (e) {
      debugPrint("Error updating user details: $e");
    }
  }
}
