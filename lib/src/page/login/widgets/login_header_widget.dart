import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/divider.dart';
import 'package:quantum_app_summer_2023/src/controller/login_controller.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: Get.width - 40,
          child: OutlinedButton.icon(
            icon: Logo(
              Logos.google,
              size: 30,
            ),
            onPressed: () => LoginController.instance.googleSignIn(),
            label: const Text("Login with Google"),
          ),
        ),
        const SizedBox(height: 30),
        CustomDivider(
          hasText: true,
          text: "Or login with",
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
