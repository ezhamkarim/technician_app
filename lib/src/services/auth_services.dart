import 'package:firebase_auth/firebase_auth.dart';
import 'package:technician_app/src/controller/user_controller.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';

import '../enum/view_state.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final bool _isLoading = false;
  AuthService(this._firebaseAuth);
  bool get getLoading => _isLoading;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<String> signIn({
    required String email,
    required String password,
    required RootProvider rootProvider,
  }) async {
    try {
      rootProvider.setState = ViewState.busy;
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      rootProvider.setState = ViewState.idle;
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.message!;
    }
  }

  Future<String> signUp(
      {required String email,
      required String password,
      required RootProvider rootProvider,
      required UserModel userModel}) async {
    try {
      //var profilePicUrl;
      rootProvider.setState = ViewState.busy;
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      // final task = await StorageService.uploadFile(
      //         destination: data['destination'], file: data['file'])
      //     .whenComplete(() {});
      // profilePicUrl = await task.ref.getDownloadURL();

      await UserController(userCredential.user!.uid).create(userModel);
      // throw FirebaseAuthException(code: code)
      rootProvider.setState = ViewState.idle;
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.message!;
    }
  }

  Future<String> signOut(
      {required RootProvider rootProvider, required Map data}) async {
    try {
      rootProvider.setState = ViewState.busy;
      await _firebaseAuth.signOut();
      rootProvider.setState = ViewState.idle;
      return "signout";
    } on FirebaseAuthException catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.message!;
    }
  }
}
