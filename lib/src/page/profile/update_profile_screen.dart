import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/constants/sizes.dart';
import 'package:quantum_app_summer_2023/src/controller/profile_controller.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';
import 'package:quantum_app_summer_2023/src/page/profile/profile_form.dart';
import 'package:quantum_app_summer_2023/src/page/profile/widgets/image_with_icon.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
      appBar: AppBar(
          leadingWidth: 100,
          leading: GestureDetector(
              onTap: () => Get.back(),
              child: Row(children: [
                SizedBox(
                  width: 20,
                ),
                LineIcon.times(),
                SizedBox(
                  width: 5,
                ),
                Text("Close")
              ]))),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel user = snapshot.data as UserModel;
                  final email = TextEditingController(text: user.email);
                  final password = TextEditingController(text: user.password);
                  final fullName = TextEditingController(text: user.fullName);
                  final phoneNo = TextEditingController(text: user.phoneNo);

                  return Column(
                    children: [
                      const ImageWithIcon(),
                      const SizedBox(height: 50),
                      ProfileFormScreen(
                          fullName: fullName,
                          email: email,
                          phoneNo: phoneNo,
                          password: password,
                          user: user),
                    ],
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
        ),
      ),
    );
  }
}
