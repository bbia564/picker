import 'dart:typed_data';

import 'package:color_extraction/db_color/color_entity.dart';
import 'package:color_extraction/db_color/db_color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ColorSecondLogic extends GetxController {

  VoidCallback? onButtonClicked;

  DBColor dbColor = Get.find();

  var list = <ColorEntity>[].obs;

  void getData() async {
    list.value = await dbColor.getColorAllData();
  }

  void clean() {
    image = null;
    currentHex.value = '#FFFFFF';
    update();
  }

  Uint8List? image;

  var currentHex = '#FFFFFF'.obs;

  void imageSelected() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(imageQuality: 90,maxWidth: 1024,source: ImageSource.gallery);
      if (pickedFile != null) {
        final imageBytes = await pickedFile.readAsBytes();
        image = imageBytes;
        update();
        Future.delayed(const Duration(milliseconds: 100),(){
          onButtonClicked?.call();
        });
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Please check album permissions or select a new image');
      return;
    }
  }

  void save() async {
    if (image == null) {
      Fluttertoast.showToast(msg: 'Please select an image');
      return;
    }
    if (currentHex.value.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select a color');
      return;
    }
    await dbColor.insertColor(ColorEntity(
      id: 0,
      content: currentHex.value,
      createdTime: DateTime.now(),
    ));
    getData();
    Fluttertoast.showToast(msg: 'Saved');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
