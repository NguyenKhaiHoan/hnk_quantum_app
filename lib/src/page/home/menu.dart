import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/divider.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/controller/profile_controller.dart';
import 'package:quantum_app_summer_2023/src/model/user_model.dart';
import 'package:quantum_app_summer_2023/src/page/profile/update_profile_screen.dart';
import 'package:quantum_app_summer_2023/src/page/welcome/welcome_screen.dart';
import 'package:quantum_app_summer_2023/src/repository/authentication_repository/authentication_repository.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/user.png",
                      height: 70,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FutureBuilder(
                            future: controller.getUserData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  UserModel user = snapshot.data as UserModel;

                                  return Text(
                                    user.fullName,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    softWrap: true,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: whiteColor,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text(snapshot.error.toString()));
                                } else {
                                  return const Center(
                                      child: Text('Something went wrong'));
                                }
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: whiteColor,
                                  strokeWidth: 2,
                                ));
                              }
                            },
                          ),
                        ),
                        IconButton(
                            onPressed: () => Get.to(UpdateProfileScreen()),
                            icon: Icon(
                              LineIcons.edit,
                              color: whiteColor,
                            ))
                      ],
                    ),
                  ],
                ),
                Wrap(
                  spacing: 15,
                  runSpacing: 15,
                  children: [
                    CustomDivider(),
                    MenuItem(
                        icon: Icon(
                            Get.isDarkMode ? LineIcons.moon : LineIcons.sun,
                            color: whiteColor),
                        title: Get.isDarkMode ? "Dark Mode" : "Light Mode"),
                    MenuItem(
                        icon: Icon(LineIcons.infoCircle, color: whiteColor),
                        title: "Infomation"),
                    MenuItem(
                        icon: Icon(
                          LineIcons.questionCircle,
                          color: whiteColor,
                        ),
                        title: "Help & Support"),
                    CustomDivider(),
                    MenuItem(title: "Privacy Policy"),
                    MenuItem(title: "Terms & Conditions"),
                  ],
                ),
              ],
            ),
            MenuItem(
              onPressed: () {
                Get.defaultDialog(
                  backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
                  barrierDismissible: false,
                  title: "Logout",
                  titleStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                  content: Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, bottom: 10, top: 5),
                    child: Column(
                      children: [
                        Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromRGBO(251, 109, 169, 0.3)),
                          child: Center(
                            child: Container(
                              height: 110,
                              width: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(251, 109, 169, 1),
                              ),
                              child: Icon(
                                LineIcons.alternateSignOut,
                                color: whiteColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Are you sure, you want to Logout?")
                      ],
                    ),
                  ),
                  confirm: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: GradientButton(
                      onPressed: () {
                        Get.offAll(WelcomeScreen());
                        AuthenticationRepository.instance.logout();
                      },
                      widget: const Text("Yes"),
                    ),
                  ),
                  cancel: Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: OutlinedButton(
                        onPressed: () => Get.back(), child: const Text("No")),
                  ),
                );
              },
              title: "Logout",
              icon: Icon(LineIcons.alternateSignOut, color: whiteColor),
            )
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({super.key, this.icon, required this.title, this.onPressed});

  final Widget? icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null ? icon! : Container(),
          SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: TextStyle(color: whiteColor),
          )
        ],
      ),
    );
  }
}
