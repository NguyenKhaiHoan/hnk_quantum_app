import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:quantum_app_summer_2023/firebase_options.dart';
import 'package:quantum_app_summer_2023/src/repository/authentication_repository/authentication_repository.dart';
import 'package:quantum_app_summer_2023/src/utils/app_bindings.dart';
import 'package:quantum_app_summer_2023/src/utils/theme/theme.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBinding(),
      themeMode: ThemeMode.system,
      theme: CustomAppTheme.lightTheme,
      darkTheme: CustomAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 500),
      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
