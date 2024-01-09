import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/features/auth/model/user.dart';
import 'package:taskproject/features/auth/repostiory/auth.repo.dart';
import 'package:taskproject/utils/keys.dart';
import 'package:taskproject/utils/utils.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final authRepo = AuthRepository();

  Future<void> registerUser(BuildContext context, UserModel user) async {
    AppUtils.showLoadingNoTimer();
    await authRepo.registerUser(user).then((userValue) {
      AppUtils.cancelLoading();
      if (userValue != null) {
        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful!'),
            duration: Duration(seconds: 2),
          ),
        );
        AppKeys.mainAppNav.currentState?.pushNamed('/home');
      }

      _isLoading = false;
    }).onError((error, stackTrace) {
      AppUtils.cancelLoading();
      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    _isLoading = true;
    AppUtils.showLoadingNoTimer();
    await authRepo.loginUser(email, password).then((userValue) async {
      AppUtils.cancelLoading();
      if (userValue != null) {
        User? currentUser = FirebaseAuth.instance.currentUser;

        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('welcome, ${currentUser?.displayName}'),
            duration: const Duration(seconds: 2),
          ),
        );
        AppKeys.mainAppNav.currentState?.pushNamed('/home');
      }
      _isLoading = false;
    }).onError((error, stackTrace) {
      AppUtils.cancelLoading();
      _isLoading = false;
      // Show success Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$error'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
    notifyListeners();
  }
}
