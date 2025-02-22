import 'package:get/get.dart';

import 'color_first_logic.dart';

class ColorFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColorFirstLogic());
  }
}
