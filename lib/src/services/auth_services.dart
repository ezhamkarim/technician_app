import 'package:firebase_auth/firebase_auth.dart';
import 'package:technician_app/src/controller/user_controller.dart';
import 'package:technician_app/src/helper/log_helper.dart';
import 'package:technician_app/src/model/user_model.dart';
import 'package:technician_app/src/provider/root_provider.dart';
import 'package:technician_app/src/services/firebase_messaging_service.dart';

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
      var credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      var userModel =
          await UserController(credential.user!.uid).read(rootProvider).first;

      var token = await FirebaseMessagingService.getFirebaseToken ?? '';
      logSuccess('Token : $token');
      userModel.pushToken = token;

      await UserController(credential.user!.uid).update(userModel);
      rootProvider.setState = ViewState.idle;
      return "Signed In";
    } on FirebaseAuthException catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.message!;
    } catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.toString();
    }
  }

  Future<String> signUp(
      {required String email,
      required String password,
      required RootProvider rootProvider,
      required UserModel userModel}) async {
    try {
      rootProvider.setState = ViewState.busy;
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await UserController(userCredential.user!.uid).create(userModel);
      rootProvider.setState = ViewState.idle;
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.message!;
    } catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.toString();
    }
  }

  Future<String> signOut(
      {required RootProvider rootProvider,
      required UserModel userModel}) async {
    try {
      rootProvider.setState = ViewState.busy;
      userModel.pushToken = '';
      userModel.chatWith = '';
      await UserController(userModel.id).update(userModel);
      await _firebaseAuth.signOut();

      rootProvider.setState = ViewState.idle;
      return "signout";
    } on FirebaseAuthException catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.message!;
    } catch (e) {
      rootProvider.setState = ViewState.idle;
      throw e.toString();
    }
  }

  Future<String> sendResetPasswordLink(
      {required String email, required RootProvider rootProvider}) async {
    try {
      rootProvider.setState = ViewState.busy;

      await _firebaseAuth.sendPasswordResetEmail(email: email);

      rootProvider.setState = ViewState.idle;
      return 'Sent!';
    } catch (e) {
      logError('Error sent reset password ${e.toString()}');
      rootProvider.setState = ViewState.idle;
      throw e.toString();
    }
  }

  Future<String> updatePassword(
      {required User user,
      required String newPassword,
      required RootProvider rootProvider}) async {
    try {
      rootProvider.setState = ViewState.busy;

      await user.updatePassword(newPassword);

      rootProvider.setState = ViewState.idle;
      return 'Sent!';
    } catch (e) {
      logError('Error sent reset password ${e.toString()}');
      rootProvider.setState = ViewState.idle;
      throw e.toString();
    }
  }
}
