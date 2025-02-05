import 'package:flutter/material.dart';

import '../../../res/color_manager.dart';
import '../../../widget/button_primary.dart';
import 'location_in_sheet.dart';

class FromToLoction extends StatelessWidget {
  const FromToLoction({
    super.key,
    required this.fromLocationName,
    required this.fromLocationDescreption,
    required this.toLocationName,
    required this.toLocationDescreption,
    required this.press,
  });

  final String fromLocationName;
  final String fromLocationDescreption;
  final String toLocationName;
  final String toLocationDescreption;
  final void Function() press;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            LocationInSheet(
              color: ColorManager.red,
              name: fromLocationName,
              desc: fromLocationDescreption,
            ),
            LocationInSheet(
              color: ColorManager.primary,
              name: toLocationName,
              desc: toLocationDescreption,
            ),
            ButtonPrimary(press: press, text: "text"),
          ],
        ),
      ),
    );
  }
}
