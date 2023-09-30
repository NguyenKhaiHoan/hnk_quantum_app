import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/repository/authentication_repository/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final isLoading = false.obs;

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading.value = true;
      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email, password);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
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

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      isLoading.value = true;
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }

  Future<void> deleteUser(String email, String password) async {
    try {
      isLoading.value = true;
      await AuthenticationRepository.instance.deleteUser(email, password);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 5));
    }
  }
}
