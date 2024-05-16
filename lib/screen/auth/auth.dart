import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/color_manager.dart';
import '../../res/key.dart';
import '../splash/splash.dart';
import '../trip/trip_screen.dart';
import 'auth_controller.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    GetStorage();
    Timer(const Duration(seconds: 5), () async {
      var v = await authController.getVersion();
      v = v ?? '';
      if (int.parse(version.substring(version.indexOf('+'))) >=
          int.parse(v.substring(v.indexOf('+')))) {
        var b = await authController.checkToken();
        if (b) {
          Get.offAll(const TripScreen());
        } else {
          Get.offAll(const SplashScreen());
        }
      } else {
        Get.dialog(AlertDialog(
          title: const Text('تحديث'),
          content: const Text('هذا الاصدار قديم الرجاء تحديث التطبيق'),
          actions: [
            TextButton(
                onPressed: () async {
                  if (await canLaunchUrl(urlGoolePlay)) {
                    await launchUrl(urlGoolePlay);
                  }
                },
                child: const Text(
                  'تحديث',
                  style: TextStyle(color: ColorManager.red),
                ))
          ],
        ));
      }
    });
    return const SplashScreen();
  }
}
