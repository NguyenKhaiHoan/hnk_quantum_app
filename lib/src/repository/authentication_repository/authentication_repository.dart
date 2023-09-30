import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quantum_app_summer_2023/src/page/home/zoom_drawer.dart';
import 'package:quantum_app_summer_2023/src/page/login/login_screen.dart';
import 'package:quantum_app_summer_2023/src/page/welcome/welcome_screen.dart';

import 'exceptions/t_exceptions.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  late final GoogleSignInAccount googleUser;
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> _firebaseUser;
  var verificationId = ''.obs;

  User? get firebaseUser => _firebaseUser.value;

  String get getUserID => _firebaseUser.value?.uid ?? "";

  String get getUserEmail => _firebaseUser.value?.email ?? "";

  String get getUserPhoneNo => _firebaseUser.value?.phoneNumber ?? "";

  @override
  void onReady() {
    _firebaseUser = Rx<User?>(_auth.currentUser);
    _firebaseUser.bindStream(_auth.userChanges());
    FlutterNativeSplash.remove();
    ever(_firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    user == null
        ? Get.offAll(() => const WelcomeScreen())
        : Get.offAll(() => DrawerScreen());
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      googleUser = (await GoogleSignIn().signIn())!;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Unknown Error Occurred. Try again!'
          : e.toString();
    }
  }

  loginWithPhoneNo(String phoneNumber) async {
    try {
      await _auth.signInWithPhoneNumber(phoneNumber);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-phone-number') {
        Get.snackbar("Error", "Invalid Phone No");
      }
    } catch (_) {
      Get.snackbar("Error", "Something went wrong.");
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final result =
          TExceptions.fromCode(e.code); // Throw custom [message] variable
      throw result.message;
    } catch (_) {
      const result = TExceptions();
      throw result.message;
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser != null
          ? Get.offAll(() => const DrawerScreen())
          : Get.to(() => const WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().disconnect();
    await _auth.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        Get.offAll(const LoginScreen());
        Get.snackbar("Password Reset email link is been sent", "Success");
      });
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }

  Future<void> deleteUser(String email, String password) async {
    try {
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!
          .reauthenticateWithCredential(credential)
          .then((value) {
        value.user!.delete().then((value) => {
              Get.offAll(const LoginScreen()),
              Get.snackbar("Account is deleted", "Success")
            });
      });
    } on FirebaseAuthException catch (e) {
      final ex = TExceptions.fromCode(e.code);
      throw ex.message;
    } catch (_) {
      const ex = TExceptions();
      throw ex.message;
    }
  }
}
