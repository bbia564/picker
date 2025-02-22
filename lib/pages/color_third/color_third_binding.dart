import 'package:get/get.dart';

import 'color_third_logic.dart';

class ColorThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColorThirdLogic());
  }
}
