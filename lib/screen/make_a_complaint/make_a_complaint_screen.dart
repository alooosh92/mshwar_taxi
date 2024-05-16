import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/validator_manager.dart';
import '../../widget/app_bar_all.dart';
import '../../widget/button_primary.dart';
import '../../widget/snackbar_def.dart';
import '../../widget/text_form_fiels_def.dart';
import 'make_a_complaint_controller.dart';

class MakeAComplaintScreen extends StatelessWidget {
  const MakeAComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    MakeAComplaintController aComplaintController = Get.find();
    TextEditingController body = TextEditingController();
    TextEditingController subject = TextEditingController();
    return Scaffold(
      appBar: appBarAll(
          press: () => Get.back(),
          icon: Icons.arrow_back_ios,
          title: "تواصل معنا"),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset(
                  "lib/asset/images/MakeAComplaintScreen.png",
                  width: MediaQuery.sizeOf(context).height / 3,
                  height: MediaQuery.sizeOf(context).height / 3,
                ),
                TextFormFieldRadius(
                  controller: subject,
                  hint: "الموضوع",
                  radius: 10,
                  line: 1,
                  validator: ValidatorManager.name,
                ),
                TextFormFieldRadius(
                  controller: body,
                  hint: "نص الرسالة",
                  radius: 10,
                  line: 5,
                  topPadding: 20,
                  validator: ValidatorManager.name,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ButtonPrimary(
                      press: () async {
                        if (formKey.currentState!.validate()) {
                          var res = await aComplaintController.sendMessage(
                              subject.text, body.text);
                          if (res) {
                            Get.back();
                            snackbarDef("ملاحظة",
                                "تم ارسال الرسالة\nشكرا لتواصلك معنا");
                          } else {
                            snackbarDef(
                                "تحذير", "حدث خطأ ما الرجاء المحاولة لاحقاً");
                          }
                        }
                      },
                      text: "ارسال"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
