import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/services/database_service.dart';

import '../services/storage_services.dart';

class UserController extends DatabaseService {
  final String uid;

  UserController(this.uid);

  Future<void> create(UserModel userModel) async {
    try {
      userModel.id = uid;
      await userDataCollection.doc(uid).set(userModel.toMap());
    } catch (e) {
      logError('Error create user');
      return;
    }
  }

  Future<void> update(UserModel userModel) async {
    try {
      await userDataCollection.doc(uid).set(userModel.toMap());
    } catch (e) {
      logError('Error update user');
      return;
    }
  }

  Future<void> updateImage(UserModel userModel, Map data) async {
    try {
      final task = await StorageService.uploadFile(
          destination: data['destination'], file: data['file']);
      if (task != null) {
        var profilePicUrl = await task.ref.getDownloadURL();
        userModel.pictureLink = profilePicUrl;
        await userDataCollection.doc(uid).set(userModel.toMap());
      }
    } catch (e) {
      logError('Error update user');
      return;
    }
  }

  Stream<UserModel> read(RootProvider rootProvider) {
    return userDataCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      var user = UserModel.fromSnapshot(snapshot);
      rootProvider.setUser = user;
      return user;
    });
  }

  Stream<List<UserModel>> readTechnician() {
    return userDataCollection
        .where('role', isEqualTo: 'Technician')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }
}
