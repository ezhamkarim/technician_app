import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static UploadTask? uploadFile(
      {required String destination, required File file}) {
    try {
      final storage = FirebaseStorage.instance;

      return storage.ref(destination).putFile(file);
    } on FirebaseException catch (e) {
      log(e.toString());
      return null;
    }
  }
}
