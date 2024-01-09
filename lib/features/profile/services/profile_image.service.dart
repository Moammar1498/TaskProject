import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:taskproject/features/profile/provider/user_profile.provider.dart';
import 'package:taskproject/utils/colors.dart';

class ProfileImageService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<File?> pickAndCropImageFromGallery(ImageSource imageSrc) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSrc);
    if (pickedFile == null) return null;

    return await _cropImage(File(pickedFile.path));
  }

  static Future<File?> _cropImage(File imageFile) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      compressQuality: 50,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
      ],
    );
    final image = File(croppedFile!.path);
    return image;
  }

  static Future<String?> uploadImageToFirebaseStorage(
      File imageFile, String userId, isFamilyMember) async {
    var downloadURL = '';
    try {
      if (isFamilyMember) {
        final storageReference = _storage
            .ref()
            .child('profile_images')
            .child(userId)
            .child('familyMember');
        final uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() async {
          final String imageURL = await storageReference.getDownloadURL();
          debugPrint(imageURL);
          downloadURL = imageURL;
        });
      } else {
        final storageReference =
            _storage.ref().child('profile_images').child(userId);
        final uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() async {
          final String imageURL = await storageReference.getDownloadURL();
          debugPrint(imageURL);
          downloadURL = imageURL;
        });
      }
    } catch (e) {
      debugPrint('Error uploading image to Firebase Storage: $e');
      return null;
    }
    return downloadURL;
  }

  static Future<void> updatePhotoUrl(String userId, String photoUrl) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({'photoUrl': photoUrl});
    } catch (e) {
      debugPrint('Error updating photo URL in Firestore: $e');
    }
  }

  static Future<String?> getProfilePicture(BuildContext context, String userId,
      ImageSource imageSource, isFamilyMember) async {
    String? imageUrl = '';
    try {
      File? imageFile = await pickAndCropImageFromGallery(imageSource);
      if (imageFile != null) {
        if (isFamilyMember) {
          imageUrl =
              await uploadImageToFirebaseStorage(imageFile, userId, true);
        } else {
          imageUrl =
              await uploadImageToFirebaseStorage(imageFile, userId, false);
        }
        debugPrint('url: $imageUrl');
      }
    } catch (e) {
      debugPrint('Error updating profile picture: $e');
      return null;
    }
    return imageUrl;
  }

  static Future<void> updateProfilePicture(
      BuildContext context, String userId, ImageSource imageSource) async {
    try {
      File? imageFile = await pickAndCropImageFromGallery(imageSource);
      if (imageFile != null) {
        String? downloadURL =
            await uploadImageToFirebaseStorage(imageFile, userId, false);
        debugPrint('url: $downloadURL');
        if (downloadURL != null) {
          debugPrint('url: $downloadURL');
          await updatePhotoUrl(userId, downloadURL);
          if (!context.mounted) return;
          context.read<ProfileProvider>().getCurrentUser();
        }
      }
    } catch (e) {
      debugPrint('Error updating profile picture: $e');
    }
  }
}
