import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../res/font_manager.dart';
import '../../../res/validator_manager.dart';
import '../../../widget/button_primary.dart';
import '../../../widget/snackbar_def.dart';
import '../../../widget/text_form_fiels_def.dart';
import '../../app_info/app_info.dart';
import '../../app_info/app_info_controller.dart';
import '../auth_controller.dart';
import '../widget/row_text_button.dart';
import 'opt.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController phone = TextEditingController();
    AuthController authController = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              autovalidateMode: AutovalidateMode.always,
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'lib/asset/images/sh.png',
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  const Text(
                    "تسجيل الدخول",
                    style: FontManager.w600s30cB,
                  ),
                  TextFormFieldRadius(
                    controller: phone,
                    hint: "رقم الهاتف",
                    validator: (value) => ValidatorManager.phone(value),
                    keyType: TextInputType.phone,
                  ),
                  ButtonPrimary(
                      press: () async {
                        if (formKey.currentState!.validate()) {
                          var b = await authController.login(phone.text);
                          if (b) {
                            Get.to(OptScreen(phone: phone.text));
                          } else {
                            snackbarDef("خطأ", "الرقم غير موجود");
                          }
                        }
                      },
                      text: "تسجيل دخول"),
                  RowTextButton(
                      text: "لا تملك حساب بعد؟",
                      textButton: "أنشأ حساب مجاناً",
                      press: () async {
                        AppInfoController appInfoController = Get.find();
                        Get.offAll(AppInfo(
                          tileAppBar: 'شروط الاستخدام',
                          isRegister: true,
                          list: await appInfoController.getTream(1),
                        ));
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
