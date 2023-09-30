import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget(
    this.widget, {
    super.key,
    this.gradient,
  });

  final Widget widget;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) {
        if (gradient == null) {
          return const LinearGradient(
            colors: [
              Color.fromRGBO(187, 63, 221, 1),
              Color.fromRGBO(251, 109, 169, 1),
              Color.fromRGBO(255, 159, 124, 1),
            ],
          ).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        } else {
          return gradient!.createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          );
        }
      },
      child: widget,
    );
  }
}
