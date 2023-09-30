import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/constants/sizes.dart';
import 'package:quantum_app_summer_2023/src/constants/text_strings.dart';
import 'package:quantum_app_summer_2023/src/controller/login_controller.dart';

class LoginFormWidget extends StatelessWidget {
  const LoginFormWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final formKeyLogin = GlobalKey<FormState>();
    final formKeyForgotPass = GlobalKey<FormState>();

    return Form(
      child: Container(
        child: Form(
          key: formKeyLogin,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == '' || value == null) {
                    return "Add your Email";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Invalid Email Address";
                  } else {
                    return null;
                  }
                },
                controller: controller.email,
                decoration: const InputDecoration(
                    prefixIcon: GradientWidget(
                      Icon(LineIcons.envelope),
                      gradient: null,
                    ),
                    labelText: textEmail,
                    hintText: textEmail),
              ),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: controller.password,
                validator: (value) {
                  if (value == '' || value == null) {
                    return "Enter your Password";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  prefixIcon: GradientWidget(
                    Icon(LineIcons.lock),
                    gradient: null,
                  ),
                  labelText: textPassword,
                  hintText: textPassword,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      builder: (context) => Container(
                        color: Get.isDarkMode ? darkColor : whiteColor,
                        padding: const EdgeInsets.all(tDefaultSize),
                        child: Form(
                            key: formKeyForgotPass,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(textForgetPasswordTitle,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(textForgetPasswordSubTitle,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: controller.email,
                                  decoration: const InputDecoration(
                                      prefixIcon: Icon(LineIcons.envelope),
                                      labelText: textEmail,
                                      hintText: textEmail),
                                ),
                                const SizedBox(height: 20.0),
                                Obx(
                                  () => GradientButton(
                                    onPressed: controller.isLoading.value
                                        ? () {}
                                        : () {
                                            if (formKeyForgotPass.currentState!
                                                .validate()) {
                                              LoginController.instance
                                                  .sendPasswordResetEmail(
                                                      controller.email.text
                                                          .trim());
                                            }
                                          },
                                    widget: controller.isLoading.value
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: const [
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Text("Loading...")
                                            ],
                                          )
                                        : Text("Send"),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            )),
                      ),
                    ),
                    child: const Text(textForgetPassword),
                  ),
                ],
              ),
              Obx(
                () => GradientButton(
                  onPressed: controller.isLoading.value
                      ? () {}
                      : () {
                          if (formKeyLogin.currentState!.validate()) {
                            LoginController.instance.loginUser(
                                controller.email.text.trim(),
                                controller.password.text.trim());
                          }
                        },
                  widget: controller.isLoading.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text("Loading...")
                          ],
                        )
                      : Text(textLogin.toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
