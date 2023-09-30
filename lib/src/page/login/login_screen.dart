import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/form/form_header_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/constants/sizes.dart';
import 'package:quantum_app_summer_2023/src/constants/text_strings.dart';
import '../signup/signup_screen.dart';
import 'widgets/login_header_widget.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
        appBar: AppBar(
            leadingWidth: 100,
            leading: GestureDetector(
                onTap: () => Get.back(),
                child: Row(children: [
                  SizedBox(
                    width: 20,
                  ),
                  LineIcon.arrowLeft(),
                  SizedBox(
                    width: 5,
                  ),
                  Text("Back")
                ]))),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              FormHeaderWidget(
                title: textLoginTitle,
                subTitle: textLoginSubTitle,
              ),
              LoginHeaderWidget(),
              LoginFormWidget(),
              TextButton(
                onPressed: () => Get.off(() => const SignUpScreen()),
                child: Text.rich(
                  TextSpan(
                      text: textDontHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                      children: const [
                        TextSpan(
                            text: textSignup,
                            style: TextStyle(color: Colors.blue))
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
