import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/update_user.dart';
import '../../../models/user_register.dart';
import '../../../res/validator_manager.dart';
import '../../../widget/app_bar_all.dart';
import '../../../widget/button_primary.dart';
import '../../../widget/progress_def.dart';
import '../../../widget/snackbar_def.dart';
import '../../../widget/text_form_fiels_def.dart';
import '../../trip/trip_screen.dart';
import '../auth_controller.dart';
import 'opt.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    AuthController authController = Get.find();
    TextEditingController name = TextEditingController();
    TextEditingController phone = TextEditingController();
    TextEditingController email = TextEditingController();
    String? region;
    return Scaffold(
      appBar: appBarAll(
          press: () => Get.back(),
          icon: Icons.arrow_back_ios,
          title: "تعديل الملف الشخصي"),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: authController.getRegion(),
              builder: (BuildContext context, AsyncSnapshot regionCity) {
                return FutureBuilder<UserRegister?>(
                  future: authController.userProfile(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const ProgressDef();
                    }
                    name.text = snapshot.data.name;
                    email.text = snapshot.data.email ?? '';
                    phone.text = snapshot.data.phone;
                    region = snapshot.data.region;
                    return Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.always,
                      child: Column(
                        children: [
                          Image.asset(
                            'lib/asset/images/sh.png',
                            fit: BoxFit.cover,
                            height: 170,
                            width: MediaQuery.sizeOf(context).width,
                          ),
                          TextFormFieldRadius(
                            controller: name,
                            hint: "الرجاء ادخال الاسم الحقيقي",
                            topPadding: 30,
                            validator: (value) => ValidatorManager.name(value),
                          ),
                          TextFormFieldRadius(
                            controller: phone,
                            hint: "رقم الهاتف",
                            topPadding: 30,
                            validator: (value) => ValidatorManager.phone(value),
                          ),
                          TextFormFieldRadius(
                            controller: email,
                            hint: "البريد الالكتروني",
                            topPadding: 30,
                          ),
                          const SizedBox(height: 30),
                          DropdownButtonFormField<String?>(
                              value: region,
                              validator: (value) =>
                                  ValidatorManager.name(value),
                              decoration: inputDecorationDef(radius: 30),
                              items: regionCity.data,
                              onChanged: (value) {
                                region = value!;
                              }),
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: ButtonPrimary(
                                press: () async {
                                  if (formKey.currentState!.validate()) {
                                    var user = UpdateUser(
                                        name: name.text,
                                        phone: phone.text,
                                        email: email.text,
                                        region: region!);
                                    var b = await authController
                                        .updateProfile(user);
                                    if (b) {
                                      snackbarDef(
                                          "ملاحظة", "تم تعديل البيانات بنجاح");
                                    } else {
                                      snackbarDef("تحذير",
                                          "هناك خطأ ما الرجاء الاتصال بالمسؤول");
                                    }

                                    if (snapshot.data.phone != phone.text) {
                                      await authController.login(phone.text);
                                      Get.offAll(OptScreen(phone: phone.text));
                                    } else {
                                      Get.off(const TripScreen());
                                    }
                                  }
                                },
                                text: "تحديث الملف الشخصي"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
