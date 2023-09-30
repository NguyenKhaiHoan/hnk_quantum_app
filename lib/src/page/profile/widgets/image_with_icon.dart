import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ImageWithIcon extends StatelessWidget {
  const ImageWithIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/user.png",
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(187, 63, 221, 1),
                  Color.fromRGBO(251, 109, 169, 1),
                  Color.fromRGBO(255, 159, 124, 1)
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: const Icon(LineIcons.pen, size: 20),
          ),
        ),
      ],
    );
  }
}
