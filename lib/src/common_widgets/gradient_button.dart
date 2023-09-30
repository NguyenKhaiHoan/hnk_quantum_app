import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {Key? key, required this.onPressed, required this.widget})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(187, 63, 221, 1),
            Color.fromRGBO(251, 109, 169, 1),
            Color.fromRGBO(255, 159, 124, 1)
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(395, 60),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: widget),
    );
  }
}
