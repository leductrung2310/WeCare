import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wecare_flutter/services/authentic_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final _picker = ImagePicker();
  String _pathAvatar = 'assets/images/profile/avatar.png';
  bool _checkAvatar = true;
  late BuildContext _buildContext;

  BuildContext get buildContext => _buildContext;
  set buildContext(value) {
    _buildContext = value;
  }

  get checkAvatar => _checkAvatar;
  set checkAvatar(value) {
    _checkAvatar = value;
  }

  String get pathAvatar => _pathAvatar;
  set pathAvatar(value) {
    _pathAvatar = value;
  }

  void selectImageSource(ImageSource imageSource, context) async {
    final pickedImage = await _picker.pickImage(source: imageSource);

    if (pickedImage == null) {
      return;
    }
    //_pathAvatar = pickedImage.path;

    await uploadImageToFirebase(pickedImage.path, context);
  }

  Future uploadImageToFirebase(String url, context) async {
    File file = File(url);

    var ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Users/${FirebaseAuth.instance.currentUser!.uid}/')
        .child('avatar');
    try {
      await ref.putFile(file);
      String _image = await ref.getDownloadURL();

      if (_image.isNotEmpty) {
        updateUserAvatar(_image);
        setAvatar(_image, context);
      }
    } on FirebaseException {
      return null;
    }
  }

  Future<String> getUrlAvatar() async {
    String url =
        'https://firebasestorage.googleapis.com/v0/b/wecare-da049.appspot.com/o/default_avatar.png?alt=media&token=2c3cb547-e2d2-4e14-a6da-ee15b04ccb6e';

    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref()
          .child('Users/${FirebaseAuth.instance.currentUser!.uid}/')
          .child('avatar')
          .getDownloadURL();
      // ignore: empty_catches
    } on FirebaseException {}
    return url;
  }

  void setAvatar(value, context) {
    Provider.of<AuthenticService>(context, listen: false).setAvatar = value;
  }

  Future updateUserAvatar(String url) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      'avatarUrl': url,
    });
  }
}
