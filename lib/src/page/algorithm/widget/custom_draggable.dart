import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/controller/sheet_controller.dart';

class DraggableSheetWidget extends StatelessWidget {
  final SheetController sheetController;
  final Widget child;

  DraggableSheetWidget(this.sheetController, {required this.child});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        left: 0,
        right: 0,
        top: sheetController.position.value,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            final newPosition =
                sheetController.position.value + details.delta.dy;
            sheetController.updatePosition(newPosition.clamp(0.0, 300.0));
          },
          onVerticalDragEnd: (_) {
            final halfScreen = MediaQuery.of(context).size.height / 2;
            if (sheetController.position.value < halfScreen) {
              sheetController.updatePosition(0);
            } else {
              sheetController.updatePosition(halfScreen);
            }
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(sheetController.borderRadius.value),
                topRight: Radius.circular(sheetController.borderRadius.value),
              ),
            ),
            child: DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.3,
              minChildSize: 0.1,
              maxChildSize: 1.0,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return SingleChildScrollView(
                    controller: scrollController, child: child);
              },
            ),
          ),
        ),
      ),
    );
  }
}
