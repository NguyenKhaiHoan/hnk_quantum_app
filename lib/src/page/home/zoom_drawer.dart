import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/src/constants/colors.dart';
import 'package:quantum_app_summer_2023/src/page/home/home.dart';
import 'package:quantum_app_summer_2023/src/page/home/menu.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromRGBO(255, 159, 124, 1),
            Color.fromRGBO(251, 109, 169, 1),
            Color.fromRGBO(187, 63, 221, 1),
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: ZoomDrawer(
          controller: zoomDrawerController,
          menuScreen: const MenuScreen(),
          mainScreen: const DashBoard(),
          style: DrawerStyle.defaultStyle,
          borderRadius: 24.0,
          showShadow: true,
          angle: 0.0,
          drawerShadowsBackgroundColor: Get.isDarkMode ? darkColor : whiteColor,
          openCurve: Curves.fastOutSlowIn,
          closeCurve: Curves.bounceIn,
          slideWidth: MediaQuery.of(context).size.width * 0.65),
    );
  }
}
