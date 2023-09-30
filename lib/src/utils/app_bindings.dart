import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/controller/algorithms_controller.dart';
import 'package:quantum_app_summer_2023/src/controller/game_controller.dart';
import 'package:quantum_app_summer_2023/src/controller/login_controller.dart';
import 'package:quantum_app_summer_2023/src/controller/signup_controller.dart';
import 'package:quantum_app_summer_2023/src/controller/visualization_controller.dart';
import 'package:quantum_app_summer_2023/src/repository/user_repository/user_repository.dart';
import '../repository/authentication_repository/authentication_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthenticationRepository(), fenix: true);
    Get.lazyPut(() => UserRepository(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => SignUpController(), fenix: true);
    Get.lazyPut(() => AlgorithmController(), fenix: true);
    Get.lazyPut(() => GameController(), fenix: true);
    Get.lazyPut(() => VisualizationController(), fenix: true);
  }
}
