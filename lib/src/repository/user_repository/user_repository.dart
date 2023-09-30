import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';
import '../authentication_repository/exceptions/t_exceptions.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await recordExist(user.email)
          ? throw "Record Already Exists"
          : await _db.collection("Users").add(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  Future<UserModel> getUserDetails(String email) async {
    try {
      final snapshot =
          await _db.collection("Users").where("Email", isEqualTo: email).get();
      if (snapshot.docs.isEmpty) throw 'No such user found';
      final userData =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
      return userData;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      throw e.toString().isEmpty
          ? 'Something went wrong. Please Try Again'
          : e.toString();
    }
  }

  Future<List<UserModel>> allUsers() async {
    try {
      final snapshot = await _db.collection("Users").get();
      final users =
          snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
      return users;
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  Future<void> updateUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJson());
    } on FirebaseAuthException catch (e) {
      final result = TExceptions.fromCode(e.code);
      throw result.message;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (_) {
      throw 'Something went wrong. Please Try Again';
    }
  }

  Future<bool> recordExist(String email) async {
    try {
      final snapshot =
          await _db.collection("Users").where("Email", isEqualTo: email).get();
      return snapshot.docs.isEmpty ? false : true;
    } catch (e) {
      throw "Error fetching record.";
    }
  }
}
