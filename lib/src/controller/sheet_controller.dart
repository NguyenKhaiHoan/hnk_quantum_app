import 'package:get/get.dart';

class SheetController extends GetxController {
  RxDouble borderRadius = 0.0.obs;
  RxDouble position = 0.0.obs;

  void updateBorderRadius(double value) {
    borderRadius.value = value;
  }

  void updatePosition(double value) {
    position.value = value;
  }
}
