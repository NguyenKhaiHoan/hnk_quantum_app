import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';
import 'package:quantum_app_summer_2023/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quantum_app_summer_2023/src/repository/user_repository/user_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final userRepo = UserRepository.instance;
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  final isLoading = false.obs;

  Future<void> createUser(UserModel user) async {
    try {
      isLoading.value = true;
      await emailAuthentication(user.email, user.password);
      await userRepo.createUser(user);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  Future<void> emailAuthentication(String email, String password) async {
    try {
      await AuthenticationRepository.instance
          .createUserWithEmailAndPassword(email, password);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> googleSignIn() async {
    try {
      isLoading.value = true;
      await AuthenticationRepository.instance.signInWithGoogle();
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
}
