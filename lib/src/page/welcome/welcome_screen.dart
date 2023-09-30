import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_button.dart';
import 'package:quantum_app_summer_2023/src/common_widgets/gradient_widget.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/constants/sizes.dart';
import 'package:quantum_app_summer_2023/src/constants/text_strings.dart';
import 'package:quantum_app_summer_2023/src/page/signup/signup_screen.dart';
import 'package:quantum_app_summer_2023/src/utils/animations/fade_in_animation/animation_design.dart';
import 'package:quantum_app_summer_2023/src/utils/animations/fade_in_animation/fade_in_animation_controller.dart';
import 'package:quantum_app_summer_2023/src/utils/animations/fade_in_animation/fade_in_animation_model.dart';
import '../login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.animationIn();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Get.isDarkMode ? darkColor : whiteColor,
        body: Stack(
          children: [
            TFadeInAnimation(
              isTwoWayAnimation: false,
              durationInMs: 1200,
              animate: TAnimatePosition(
                bottomAfter: 0,
                bottomBefore: 0,
                leftBefore: 0,
                leftAfter: 0,
                topAfter: 0,
                topBefore: -100,
                rightAfter: 0,
                rightBefore: 0,
              ),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/images/signin_balls.png'),
                    Padding(
                      padding: const EdgeInsets.all(tDefaultSize),
                      child: Column(children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Explore',
                              style: TextStyle(
                                  height: 0.8,
                                  fontSize: 40,
                                  color:
                                      Get.isDarkMode ? whiteColor : darkColor),
                            ),
                            const GradientWidget(
                              Text('quantum',
                                  style: TextStyle(height: 1.2, fontSize: 60)),
                              gradient: null,
                            ),
                            Row(children: [
                              GradientWidget(
                                Text('easily',
                                    style:
                                        TextStyle(height: 1.2, fontSize: 40)),
                                gradient: LinearGradient(
                                  colors: [
                                    Get.isDarkMode ? whiteColor : darkColor,
                                    Get.isDarkMode
                                        ? whiteColor.withAlpha(0)
                                        : darkColor.withAlpha(0),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              GradientWidget(
                                Text('.',
                                    style:
                                        TextStyle(height: 1.2, fontSize: 60)),
                                gradient: null,
                              ),
                            ])
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: () =>
                                  Get.to(() => const LoginScreen()),
                              child: Text(
                                textLogin.toUpperCase(),
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            GradientButton(
                                onPressed: () =>
                                    Get.to(() => const SignUpScreen()),
                                widget: Text(textSignup.toUpperCase())),
                          ],
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
