import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';

class GameController extends GetxController {
  var selectedGradientIndex = 0.obs;
  final List<List<Color>> gradients = [
    [const Color(0xFFbb3fdd), const Color(0xFFfb6da9)],
    [const Color(0xFFfb6da9), const Color(0xFFff9f7c)],
    [const Color(0xFF8bc6ec), const Color(0xFF8ec5fc)],
    [const Color(0xFFff9a8b), const Color(0xFFff6a88)],
    [const Color(0xFFeb3349), const Color(0xFFf45c43)],
    [const Color(0xFF02aab0), const Color(0xFF00cdac)],
    [const Color(0xFF72edf2), const Color(0xFF5151e5)],
    [const Color(0xFFfdeb71), const Color(0xFFf8d800)],
  ];

  var isQuantumSelected = false.obs;

  void selectQuantum(bool value) {
    isQuantumSelected.value = value;
    update();
  }

  void shuffleGradient() {
    final random = Random();
    final randomIndex = [0, 2, 4, 6][random.nextInt(4)];
    selectedGradientIndex.value =
        (selectedGradientIndex.value + 2) % gradients.length;
    update();
  }
}
