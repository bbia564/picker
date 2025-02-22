import 'dart:typed_data';
import 'package:color_extraction/pages/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'dart:ui' as ui;
import 'color_second_logic.dart';

class ColorSecondPage extends StatefulWidget {
  const ColorSecondPage({Key? key}) : super(key: key);

  @override
  State<ColorSecondPage> createState() => _ColorSecondPageState();
}

class _ColorSecondPageState extends State<ColorSecondPage> {
  final controller = Get.put(ColorSecondLogic());

  final GlobalKey _imageKey = GlobalKey();
  Offset _buttonPosition = const Offset(266 / 2, 415 / 2);

  Widget _noSelectImageWidget() {
    return <Widget>[
      Container(
        width: 131,
        height: 131,
        child: const Icon(
          Icons.add,
          size: 70,
          color: Colors.white,
        ),
      )
          .decorated(
              color: const Color(0xffe8e8e8),
              borderRadius: BorderRadius.circular(15))
          .gestures(onTap: () {
        controller.imageSelected();
      }),
      const SizedBox(
        height: 10,
      ),
      const Text('Select image'),
      const SizedBox(
        height: 40,
      ),
    ].toColumn();
  }


  Future<void> _getColorAtPosition(Offset position) async {
    final RenderRepaintBoundary boundary =
    _imageKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData();
    if (byteData != null) {
      final Uint8List pixels = byteData.buffer.asUint8List();
      final int pixelOffset =
          (position.dy.toInt() * image.width + position.dx.toInt()) * 4;
      controller.currentHex.value = _toHex(Color.fromARGB(
        255,
        pixels[pixelOffset],
        pixels[pixelOffset + 1],
        pixels[pixelOffset + 2],
      ));
    }
  }

  String _toHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}'
        .replaceRange(1, 3, '');
  }

  void _onButtonClicked() {
    _getColorAtPosition(_buttonPosition);
  }

  Widget _selectedImageWidget() {
    return <Widget>[
      <Widget>[
        Obx(() {
          return Container(
            width: 40,
            height: 40,
          ).decorated(color: HexColor(controller.currentHex.value));
        }),
        const SizedBox(
          width: 20,
        ),
        Obx(() {
          return Text(
            controller.currentHex.value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          );
        })
      ].toRow(),
      const SizedBox(
        height: 20,
      ),
      Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 266,
          height: 415,
          child: <Widget>[
            Container(
              color: Colors.transparent,
              child: RepaintBoundary(
                key: _imageKey,
                child: Image.memory(
                  controller.image!,
                  width: 266,
                  height: 415,
                  fit: BoxFit.cover,
                ),
              ),
            ).gestures(onTap: (){
              controller.imageSelected();
            }),
            Positioned(
              left: _buttonPosition.dx,
              top: _buttonPosition.dy,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _buttonPosition += details.delta;
                    _buttonPosition = Offset(
                      _buttonPosition.dx.clamp(0, 266 - 25),
                      _buttonPosition.dy.clamp(0, 415 - 25),
                    );
                    _getColorAtPosition(_buttonPosition);
                  });
                },
                child: Container(
                  width: 25,
                  height: 25,
                ).decorated(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.5),
                    border: Border.all(color: Colors.black, width: 2)),
              ),
            )
          ].toStack(),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      <Widget>[
        const Icon(
          Icons.info,
          size: 15,
          color: Color(0xffff4e00),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          'Drag the white dot for color',
          style: TextStyle(color: Color(0xffff4e00)),
        )
      ].toRow(mainAxisAlignment: MainAxisAlignment.center),
      const SizedBox(
        height: 20,
      ),
    ]
        .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
        .marginSymmetric(horizontal: 12);
  }

  @override
  Widget build(BuildContext context) {
    controller.onButtonClicked = _onButtonClicked;
    return GetBuilder<ColorSecondLogic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Custom swatches"),
          actions: [
            Visibility(
              visible: controller.image != null,
              child: const Text(
                'Save',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ).marginOnly(right: 20).gestures(onTap: () {
                controller.save();
              }),
            )
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SafeArea(
              child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              controller.image == null
                  ? _noSelectImageWidget()
                  : _selectedImageWidget(),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Obx(() {
                  return controller.list.value.isEmpty
                      ? const Center(
                          child: Text('No data'),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                  mainAxisSpacing: 12,
                                  crossAxisSpacing: 12,
                                  childAspectRatio: 46 / 60),
                          itemCount: controller.list.value.length,
                          itemBuilder: (_, index) {
                            final item = controller.list.value[index];
                            return <Widget>[
                              Container(
                                width: 40,
                                height: 40,
                              ).decorated(color: HexColor(item.content)),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                item.content,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 11),
                              )
                            ].toColumn();
                          });
                }),
              )
                  .decorated(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20))
                  .constrained(minHeight: 122)
            ].toColumn(),
          ).marginAll(15)),
        ),
      );
    });
  }
}
