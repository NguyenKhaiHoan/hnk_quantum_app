import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/form/form_header_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/constants/sizes.dart';
import 'package:quantum_app_summer_2023/src/constants/text_strings.dart';
import 'package:quantum_app_summer_2023/src/page/signup/widgets/signup_form_widget.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                FormHeaderWidget(
                  title: textSignUpTitle,
                  subTitle: textSignUpSubTitle,
                ),
                SignUpFormWidget(),
                TextButton(
                  onPressed: () => Get.off(() => const LoginScreen()),
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                      text: textAlreadyHaveAnAccount,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextSpan(text: textLogin.toUpperCase())
                  ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
