import 'package:get/get.dart';

import 'color_find_logic.dart';

class ColorFindBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
