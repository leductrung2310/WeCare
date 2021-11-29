import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileViewModel extends ChangeNotifier {
  final _picker = ImagePicker();
  String _pathAvatar = 'assets/images/profile/avatar.png';

  String get pathAvatar => _pathAvatar;
  set pathAvatar(value) {
    _pathAvatar = value;
  }

  void showImageSourceActionSheet(BuildContext context) {
    if (Platform.isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              child: const Text('Camera'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.camera);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Gallery'),
              onPressed: () {
                Navigator.pop(context);
                selectImageSource(ImageSource.gallery);
              },
            )
          ],
        ),
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.camera);
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_album),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              selectImageSource(ImageSource.gallery);
            },
          ),
        ]),
      );
    }
  }

  void selectImageSource(ImageSource imageSource) async {
    final pickedImage = await _picker.pickImage(source: imageSource);

    if (pickedImage == null) {
      return;
    }
    _pathAvatar = pickedImage.path;
    notifyListeners();
  }

  Future deleteImageToFirebase(BuildContext context) async {
    File file = File(_pathAvatar);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Users/${FirebaseAuth.instance.currentUser!.uid}/')
          .child('avatar')
          .delete();
    } on FirebaseException catch (e) {
      print("h" + e.toString());
    }
  }

  Future uploadImageToFirebase(BuildContext context) async {
    File file = File(_pathAvatar);

    try {
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Users/${FirebaseAuth.instance.currentUser!.uid}/')
          .child('avatar')
          .putFile(file);
    } on FirebaseException catch (e) {
      print("h" + e.toString());
    }
  }

  Future<String> getUrlAvatar(BuildContext context) async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/wecare-da049.appspot.com/o/default_avatar.png?alt=media&token=2c3cb547-e2d2-4e14-a6da-ee15b04ccb6e';

    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Users/${FirebaseAuth.instance.currentUser!.uid}/')
          .child('avatar')
          .getDownloadURL();
    } on FirebaseException catch (e) {
      print("h" + e.toString());
    }
    return url;
  }
}
