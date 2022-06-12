import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/services/database_service.dart';

class UserController extends DatabaseService {
  final String uid;

  UserController(this.uid);

  Future<void> create(UserModel userModel) async {
    try {
      await userDataCollection.doc(uid).set(userModel.toMap());
    } catch (e) {
      logError('Error create user');
      return;
    }
  }

  Future<void> update(UserModel userModel) async {
    try {
      //TODO: Add upload to firebase storage;

      await userDataCollection.doc(uid).set(userModel.toMap());
    } catch (e) {
      logError('Error update user');
      return;
    }
  }

  Stream<UserModel> read() {
    return userDataCollection
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot snapshot) {
      return UserModel.fromSnapshot(snapshot);
    });
  }
}
