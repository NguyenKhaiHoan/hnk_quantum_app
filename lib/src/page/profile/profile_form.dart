import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/constants/sizes.dart';
import 'package:quantum_app_summer_2023/src/constants/text_strings.dart';
import 'package:quantum_app_summer_2023/src/controller/login_controller.dart';
import 'package:quantum_app_summer_2023/src/controller/profile_controller.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';

class ProfileFormScreen extends StatelessWidget {
  const ProfileFormScreen({
    Key? key,
    required this.fullName,
    required this.email,
    required this.phoneNo,
    required this.password,
    required this.user,
  }) : super(key: key);

  final TextEditingController fullName;
  final TextEditingController email;
  final TextEditingController phoneNo;
  final TextEditingController password;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final loginController = Get.put(LoginController());

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: fullName,
            decoration: const InputDecoration(
                label: Text(textFullName),
                prefixIcon: Icon(LineAwesomeIcons.user)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: email,
            decoration: const InputDecoration(
                label: Text(textEmail),
                prefixIcon: Icon(LineAwesomeIcons.envelope_1)),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: phoneNo,
            decoration: const InputDecoration(
                label: Text(textPhoneNo),
                prefixIcon: Icon(LineAwesomeIcons.phone)),
          ),
          const SizedBox(height: 20),

          /// -- Form Submit Button
          SizedBox(
            width: double.infinity,
            child: GradientButton(
              onPressed: () async {
                final userData = UserModel(
                  id: user.id,
                  email: email.text.trim(),
                  password: password.text.trim(),
                  fullName: fullName.text.trim(),
                  phoneNo: phoneNo.text.trim(),
                );

                await controller.updateRecord(userData);
              },
              widget: const Text("Update"),
            ),
          ),
          const SizedBox(height: tDefaultSize),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FutureBuilder(
                future: controller.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      UserModel user = snapshot.data as UserModel;
                      return ElevatedButton(
                        onPressed: () {
                          loginController.deleteUser(user.email, user.password);
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(75, 75),
                            backgroundColor: Colors.redAccent.withOpacity(0.1),
                            elevation: 0,
                            foregroundColor: Colors.red,
                            shape: const CircleBorder(),
                            side: BorderSide.none),
                        child: const Text("Delete"),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: Text('Something went wrong'));
                    }
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Get.isDarkMode ? whiteColor : darkColor,
                    ));
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
