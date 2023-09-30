import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/constants/sizes.dart';
import 'package:quantum_app_summer_2023/src/controller/game_controller.dart';
import 'package:quantum_app_summer_2023/src/page/game/tic_tac_toe_home.dart';
import 'package:unicons/unicons.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final gameController = Get.put(GameController());
  bool _centerTitle = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
            pinned: true,
            leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                LineIcons.arrowLeft,
                size: 25.0,
              ),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  LineIcons.infoCircle,
                  size: 25.0,
                ),
              ),
            ],
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: _centerTitle,
                title: Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                background: Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        'Quantum',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                )),
          ),
          SliverToBoxAdapter(
              child: Padding(
            padding:
                const EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 10),
            child: Column(children: [
              const Text("Which color you want choose?"),
              const SizedBox(
                height: 20,
              ),
              Obx(() {
                return Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 2, right: 2, bottom: 20),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      BlurFilterX(
                        child: GradientWidget(
                          const Icon(UniconsLine.multiply, size: 130),
                          gradient: LinearGradient(
                            colors: gameController.gradients[
                                gameController.selectedGradientIndex.value],
                          ),
                        ),
                      ),
                      GradientWidget(
                        const Icon(UniconsLine.multiply, size: 120),
                        gradient: LinearGradient(
                          colors: gameController.gradients[
                              gameController.selectedGradientIndex.value],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              const Text("Or"),
              const SizedBox(height: 20),
              Obx(() {
                return Container(
                  padding: const EdgeInsets.all(10),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      BlurFilterO(
                        child: GradientWidget(
                          const Icon(UniconsLine.circle, size: 110),
                          gradient: LinearGradient(
                            colors: gameController.gradients[
                                gameController.selectedGradientIndex.value + 1],
                          ),
                        ),
                      ),
                      GradientWidget(
                        const Icon(UniconsLine.circle, size: 100),
                        gradient: LinearGradient(
                          colors: gameController.gradients[
                              gameController.selectedGradientIndex.value + 1],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 40),
              OutlinedButton.icon(
                onPressed: () {
                  gameController.shuffleGradient();
                },
                icon: const Icon(
                  UniconsLine.shuffle,
                  size: 15,
                ),
                label: const Text("Shuffle"),
              ),
              const SizedBox(
                height: 10,
              ),
              GradientButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      builder: (context) => Container(
                        color: Get.isDarkMode ? darkColor : whiteColor,
                        padding: const EdgeInsets.all(tDefaultSize),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Set quantum",
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                            const SizedBox(
                              height: 5,
                            ),
                            Obx(() => Text(
                                gameController.isQuantumSelected.value == true
                                    ? "Tic-tac-toe with superpositions"
                                    : "Classical tic-tac-toe, no quantum moves",
                                style: Theme.of(context).textTheme.bodyMedium)),
                            const SizedBox(height: 20.0),
                            Obx(
                              () => RadioListTile<bool>(
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text('No Quantum'),
                                value: false,
                                groupValue:
                                    gameController.isQuantumSelected.value,
                                onChanged: (value) {
                                  gameController.selectQuantum(value ?? true);
                                },
                              ),
                            ),
                            Obx(
                              () => RadioListTile<bool>(
                                contentPadding: const EdgeInsets.all(0),
                                title: const Text('Minimal Quantum'),
                                value: true,
                                groupValue:
                                    gameController.isQuantumSelected.value,
                                onChanged: (value) {
                                  gameController.selectQuantum(value ?? false);
                                },
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            GradientButton(
                                onPressed: () {
                                  if (gameController.isQuantumSelected ==
                                      false) {
                                    Get.to(const TicTacToeHomeScreen());
                                  } else {}
                                },
                                widget: const Text("Play"))
                          ],
                        ),
                      ),
                    );
                  },
                  widget: const Text("Continue"))
            ]),
          )),
        ],
      ),
    );
  }
}

class BlurFilterX extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  BlurFilterX({required this.child, this.sigmaX = 5.0, this.sigmaY = 5.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: Opacity(
              opacity: 0.01,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}

class BlurFilterO extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;
  BlurFilterO({required this.child, this.sigmaX = 5.0, this.sigmaY = 5.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        child,
        ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: sigmaX,
              sigmaY: sigmaY,
            ),
            child: Opacity(
              opacity: 0.01,
              child: child,
            ),
          ),
        ),
      ],
    );
  }
}
