import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.heightBetween,
    required this.title,
    required this.subTitle,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  final double? heightBetween;
  final String title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        SizedBox(height: heightBetween),
        Text(title, style: Theme.of(context).textTheme.displayLarge),
        Text(subTitle,
            textAlign: textAlign, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 30),
      ],
    );
  }
}
