import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/color_manager.dart';
import '../../res/font_manager.dart';
import '../../widget/button_primary.dart';
import '../auth/page/login.dart';
import '../trip/trip_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TripController tripController = Get.find();
    tripController.checkPermission();
    return Scaffold(
      backgroundColor: ColorManager.lightgreen,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            Image.asset(
              'lib/asset/images/street.png',
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              fit: BoxFit.fill,
            ),
            Positioned(
              top: 40,
              right: 10,
              left: 10,
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset(
                    'lib/asset/images/sh.png',
                    width: 350,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                width: MediaQuery.sizeOf(context).width,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('', style: FontManager.w600s33cW),
                    Text(
                      textAlign: TextAlign.center,
                      ' مرحباً بك بتطبيق مشوار معنا تنقل بسرعة وأمان',
                      style: FontManager.w600s33cW,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: ButtonPrimary(
                    press: () => Get.offAll(const LoginScreen()),
                    text: "تسجيل الدخول"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
