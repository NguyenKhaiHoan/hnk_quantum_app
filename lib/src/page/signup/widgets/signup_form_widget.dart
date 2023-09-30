import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/text_strings.dart';
import 'package:quantum_app_summer_2023/src/controller/signup_controller.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final formKey = GlobalKey<FormState>();

    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text(textFullName),
                  prefixIcon: GradientWidget(
                    Icon(LineIcons.user),
                    gradient: null,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text(textEmail),
                  prefixIcon: GradientWidget(
                    Icon(LineIcons.envelope),
                    gradient: null,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.phoneNo,
              decoration: const InputDecoration(
                  label: Text(textPhoneNo),
                  prefixIcon: GradientWidget(
                    Icon(LineIcons.phone),
                    gradient: null,
                  )),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                  label: Text(textPassword),
                  prefixIcon: GradientWidget(
                    Icon(LineIcons.lock),
                    gradient: null,
                  )),
            ),
            const SizedBox(height: 20),
            Obx(
              () => GradientButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    /// Email & Password Authentication
                    // SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());

                    /// For Phone Authentication
                    // SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());

                    /*
                       =========
                       Todo:Step - 3 [Get User and Pass it to Controller]
                       =========
                      */
                    final user = UserModel(
                      email: controller.email.text.trim(),
                      password: controller.password.text.trim(),
                      fullName: controller.fullName.text.trim(),
                      phoneNo: controller.phoneNo.text.trim(),
                    );
                    SignUpController.instance.createUser(user);
                    // SignUpController.instance
                    //     .phoneAuthentication(controller.phoneNo.text.trim());
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
                    : Text(textSignup.toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
