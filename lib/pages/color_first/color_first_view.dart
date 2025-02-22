import 'package:color_extraction/main.dart';
import 'package:color_extraction/pages/color_first/first_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'color_first_logic.dart';

class ColorFirstPage extends GetView<ColorFirstLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Default palette")),
      body: GridView.builder(
        padding:const EdgeInsets.all(15),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 18,
              crossAxisSpacing: 18,
              childAspectRatio: 72 / 85),
          itemCount: colorList.length,
          itemBuilder: (_, index) {
            final item = colorList[index];
            return FirstItem(item);
          }),
    );
  }
}
