import 'package:color_extraction/pages/color_first/color_first_logic.dart';
import 'package:color_extraction/pages/color_second/color_second_logic.dart';
import 'package:get/get.dart';

import '../color_third/color_third_logic.dart';
import 'color_tab_logic.dart';

class ColorTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ColorTabLogic());
    Get.lazyPut(() => ColorThirdLogic());
    Get.lazyPut(() => ColorSecondLogic());
    Get.lazyPut(() => ColorFirstLogic());
  }
}
