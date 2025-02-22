import 'package:color_extraction/db_color/db_color.dart';
import 'package:color_extraction/pages/color_first/color_first_binding.dart';
import 'package:color_extraction/pages/color_first/color_first_view.dart';
import 'package:color_extraction/pages/color_second/color_second_binding.dart';
import 'package:color_extraction/pages/color_second/color_second_view.dart';
import 'package:color_extraction/pages/color_tab/color_tab_binding.dart';
import 'package:color_extraction/pages/color_tab/color_tab_view.dart';
import 'package:color_extraction/pages/color_third/color_third_binding.dart';
import 'package:color_extraction/pages/color_third/color_third_view.dart';
import 'package:color_extraction/pages/no_network/no_network_binding.dart';
import 'package:color_extraction/pages/no_network/no_network_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor = Colors.black;
Color bgColor = const Color(0xfff8f8f8);

List<List<String>> colorList = [
  ['#C32965', '#D56676'],
  ['#C2293B', '#D45485'],
  ['#E4997A', '#F4CEA9'],
  ['#B278AA', '#B3CEEC'],
  ['#D45487', '#C32965', '#E4997A'],
  ['#542930', '#D56676', '#C2293B'],
  ['#E4997A', '#D45487', '#B3CEEC'],
  ['#C1A69F', '#9877AC', '#F3D0AA'],
  ['#542930', '#C32965', '#D75488', '#E79DBE'],
  ['#D56676', '#C2293B', '#B278AA', '#C32965'],
  ['#D56677', '#C2293B', '#EA9C78', '#55282F'],
  ['#D45487', '#E39A79', '#9B75AE', '#E69CBD'],
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBColor().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Pickers,
      initialRoute: '/color_tab',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> Pickers = [
  GetPage(name: '/color_first', page: () => ColorFirstPage(), binding: ColorFirstBinding()),
  GetPage(name: '/color_second', page: () => const ColorSecondPage(), binding: ColorSecondBinding()),
  GetPage(name: '/color_third', page: () => ColorThirdPage(), binding: ColorThirdBinding()),
  GetPage(name: '/color_tab', page: () => ColorTabPage(), binding: ColorTabBinding()),
  GetPage(name: '/check', page: () => NoNetworkPage(), binding: NoNetworkBinding())
];
