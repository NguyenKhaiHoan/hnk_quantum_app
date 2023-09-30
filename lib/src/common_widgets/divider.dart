import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    Key? key,
    this.hasText = false,
    this.text,
    this.textColor,
    this.dividerColor,
  }) : super(key: key);

  final bool? hasText;
  final String? text;
  final Color? textColor;
  final Color? dividerColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: hasText!
          ? [
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: dividerColor ?? Colors.grey.shade200.withOpacity(0.5),
                ),
              ),
              SizedBox(width: 10),
              Text(
                text!,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Divider(
                  thickness: 1,
                  color: dividerColor ?? Colors.grey.shade200.withOpacity(0.5),
                ),
              ),
            ]
          : [
              Expanded(
                child: Divider(
                  thickness: 2,
                  color: Colors.grey.shade200.withOpacity(0.5),
                ),
              ),
            ],
    );
  }
}
