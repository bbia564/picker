import 'package:get/get.dart';

import 'color_second_logic.dart';

class ColorSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColorSecondLogic());
  }
}
