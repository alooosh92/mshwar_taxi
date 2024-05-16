import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';
import '../res/color_manager.dart';
import '../res/font_manager.dart';
import '../res/key.dart';
import '../screen/about_us/about_us.dart';
import '../screen/app_info/app_info.dart';
import '../screen/app_info/app_info_controller.dart';
import '../screen/auth/auth_controller.dart';
import '../screen/auth/page/update_profile.dart';
import '../screen/location/loction_screen.dart';
import '../screen/make_a_complaint/make_a_complaint_screen.dart';
import '../screen/user_trip/user_trip.dart';
import 'row_text_press.dart';

class DrawerHome extends StatelessWidget {
  DrawerHome({
    super.key,
  });
  final _dialog = RatingDialog(
    image: Image.asset(
      'lib/asset/images/sh.png',
      width: 60,
    ),
    title: const Text(
      'قيم تطبيق  مشوار',
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      style: TextStyle(color: ColorManager.primary),
    ),
    starSize: 30,
    submitButtonText: 'أرسل',
    commentHint: 'اخبرنا برأيك',
    onSubmitted: (response) {
      StoreRedirect.redirect(
        androidAppId: '',
        iOSAppId: '',
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find();
    AppInfoController appInfoController = Get.find();
    return Drawer(
      backgroundColor: ColorManager.primary,
      width: MediaQuery.sizeOf(context).width,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(
                          Icons.close,
                          color: ColorManager.white,
                        )),
                  ],
                ),
                Image.asset(
                  'lib/asset/images/light_lg.png',
                  fit: BoxFit.cover,
                ),
                Text(
                  authController.user == null ? "" : authController.user!.name,
                  style: FontManager.w500s22cW,
                ),
                RowTextPress(
                  icon: Icons.account_box,
                  press: () => Get.to(const UpdateProfile()),
                  text: "حسابي",
                ),
                RowTextPress(
                  icon: Icons.account_box,
                  press: () => Get.to(const LoctionScreen()),
                  text: "العناوين المفضلة",
                ),
                RowTextPress(
                  icon: Icons.trip_origin,
                  press: () => Get.to(const UserTrip()),
                  text: "رحلاتي",
                ),
                RowTextPress(
                    icon: Icons.private_connectivity_outlined,
                    press: () async => Get.to(
                          AppInfo(
                            tileAppBar: "شروط الاستخدام",
                            isRegister: false,
                            list: await appInfoController.getTream(1),
                          ),
                        ),
                    text: "شروط الاستخدام"),
                RowTextPress(
                  icon: Icons.privacy_tip_outlined,
                  press: () async => Get.to(
                    AppInfo(
                      tileAppBar: "الخصوصية",
                      isRegister: false,
                      list: await appInfoController.getTream(0),
                    ),
                  ),
                  text: "الخصوصية",
                ),
                RowTextPress(
                  icon: Icons.factory_outlined,
                  press: () => Get.to(const AboutUs()),
                  text: "من نحن",
                ),
                RowTextPress(
                  icon: Icons.contact_emergency_outlined,
                  press: () => Get.to(const MakeAComplaintScreen()),
                  text: "تواصل معنا",
                ),
                RowTextPress(
                  icon: Icons.share,
                  press: () async {
                    // ignore: unused_local_variable
                    if (await canLaunchUrl(urlGoolePlay)) {
                      await launchUrl(urlGoolePlay);
                    }
                  },
                  text: "شارك التطبيق مع اصدقائك",
                ),
                RowTextPress(
                  icon: Icons.star,
                  press: () => showDialog(
                      context: context, builder: (context) => _dialog),
                  text: "قيم تطبيق مشوار ",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
