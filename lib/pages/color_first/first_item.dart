import 'package:color_extraction/pages/hex_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:styled_widget/styled_widget.dart';

class FirstItem extends StatefulWidget {
  const FirstItem(this.list, {Key? key}) : super(key: key);
  final List<String> list;

  @override
  State<FirstItem> createState() => _FirstItemState();
}

class _FirstItemState extends State<FirstItem> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, max) {
      int itemCount = widget.list.length;
      double itemWidth = max.maxWidth / itemCount;
      double itemHeight = max.maxHeight;
      double itemAspectRatio = itemHeight / itemWidth;
      return GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: itemAspectRatio),
          itemCount: widget.list.length,
          itemBuilder: (_, index) {
            final item = widget.list[index];
            return Container(width: double.infinity,height: double.infinity,)
                .decorated(
                    color: HexColor(item),
                    border: selectedIndex == index
                        ? Border.all(color: Colors.black, width: 1)
                        : null)
                .gestures(onTap: () {
                  setState(() {
                    selectedIndex = index;
                    ClipboardData data = ClipboardData(text: item);
                    Clipboard.setData(data);
                    Fluttertoast.showToast(msg: 'Copy success');
                    Future.delayed(const Duration(seconds: 1),(){
                      setState(() {
                        selectedIndex = -1;
                      });
                    });
                  });
            });
          });
    });
  }
}
