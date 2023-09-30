import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';
import 'package:quantum_app_summer_2023/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quantum_app_summer_2023/src/repository/user_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = AuthenticationRepository.instance;
  final _userRepo = UserRepository.instance;

  getUserData() {
    try {
      final currentUserEmail = _authRepo.getUserEmail;
      if (currentUserEmail.isEmpty) {
        Get.snackbar("Error", "No user found!",
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3));
        return;
      } else {
        return _userRepo.getUserDetails(currentUserEmail);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3));
    }
  }

  Future<List<UserModel>> getAllUsers() async => await _userRepo.allUsers();

  updateRecord(UserModel user) async {
    await _userRepo.updateUserRecord(user);
  }
}
