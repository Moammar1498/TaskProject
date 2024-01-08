import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/features/auth/model/user.dart';
import 'package:taskproject/features/profile/model/family_member.model.dart';
import 'package:taskproject/features/profile/repository/profile.repo.dart';
import 'package:taskproject/utils/keys.dart';
import 'package:taskproject/utils/utils.dart';

class ProfileProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final profileRepo = ProfileRepository();
  UserModel? _user;
  UserModel? get getUser => _user;

  void getCurrentUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final user = await profileRepo.getUserDetails(currentUser!.uid);
    _user = UserModel(
        firstName: user?['firstName'],
        lastName: user?['lastName'],
        email: currentUser.email.toString(),
        phone: user?['phone'],
        password: '',
        gender: user?['gender'],
        birthdate: user?['birthdate'],
        photoUrl: user?['photoUrl']);
    notifyListeners();
  }

  Future<void> updateUserProfile(
      BuildContext context, UserModel userModel) async {
    AppUtils.showLoadingNoTimer();
    await profileRepo.updateUserDetails(userModel).then((value) async {
      AppUtils.cancelLoading();
      context.read<ProfileProvider>().getCurrentUser();
      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully updated!'),
          duration: Duration(seconds: 2),
        ),
      );
      AppKeys.mainAppNav.currentState?.pop();

      _isLoading = false;
    }).onError((error, stackTrace) {
      AppUtils.cancelLoading();
      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating user profile: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addFamilyMember(
      BuildContext context, FamilyMember familyMember) async {
    AppUtils.showLoadingNoTimer();
    await profileRepo.addFamilyMember(familyMember).then((value) async {
      AppUtils.cancelLoading();
      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully added!'),
          duration: Duration(seconds: 2),
        ),
      );
      AppKeys.mainAppNav.currentState?.pop();

      _isLoading = false;
    }).onError((error, stackTrace) {
      AppUtils.cancelLoading();
      _isLoading = false;
      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error adding family member: $error'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
    notifyListeners();
  }
}
