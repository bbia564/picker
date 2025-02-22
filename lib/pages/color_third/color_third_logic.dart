import 'package:color_extraction/db_color/db_color.dart';
import 'package:color_extraction/pages/color_second/color_second_logic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class ColorThirdLogic extends GetxController {

  DBColor dbColor = Get.find();

  cleanColorData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel',style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbColor.cleanColorData();
            ColorSecondLogic secondLogic = Get.put(ColorSecondLogic());
            secondLogic.clean();
            secondLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutColorUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 76,
        height: 76,
      ),
      children: [
        const Text(
            """We can provide you with basic color palette and custom color extraction"""),
      ],
      context: context,
    );
  }

}
