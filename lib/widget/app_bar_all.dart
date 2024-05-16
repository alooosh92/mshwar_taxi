import 'package:flutter/material.dart';

import '../res/color_manager.dart';
import '../res/font_manager.dart';

AppBar appBarAll(
        {String? title,
        required void Function() press,
        required IconData icon}) =>
    AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        title ?? "",
        style: FontManager.w500s28cB,
      ),
      leading: IconButton(
        onPressed: press,
        icon: Icon(icon, color: ColorManager.black),
      ),
    );
