import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/page/welcome/welcome_screen.dart';

class FadeInAnimationController extends GetxController {
  static FadeInAnimationController get find => Get.find();

  RxBool animateTwoWay = false.obs;
  RxBool animateSingle = false.obs;

  Future startSplashAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animateTwoWay.value = true;
    await Future.delayed(const Duration(milliseconds: 3000));
    animateTwoWay.value = false;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.off(
      () => const WelcomeScreen(),
      duration: const Duration(milliseconds: 1000),
      transition: Transition.fadeIn,
    );
  }

  Future animationIn() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animateSingle.value = true;
  }

  Future animationOut() async {
    animateSingle.value = false;
    await Future.delayed(const Duration(milliseconds: 100));
  }
}
