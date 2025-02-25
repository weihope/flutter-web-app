import 'package:flutter/material.dart';

class HorizontalScrollGridWidget extends StatefulWidget {
  const HorizontalScrollGridWidget({
    super.key,
    required this.items,
    required this.widgetHeight,
    required this.widgetWidth,
  });
  final double widgetHeight;
  final double widgetWidth;
  final items;

  @override
  State<HorizontalScrollGridWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HorizontalScrollGridWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.widgetHeight,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        //padding: const EdgeInsets.all(2), // ✅ 整體間距
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // ✅ 每列 2 行
          childAspectRatio: 1, // 正方形
          crossAxisSpacing: 16, // 每列間距
          mainAxisSpacing: 16, // 每行間距
        ),
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('click on $index')),
              );
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.green[100],
                  child: Icon(widget.items[index]['icon'],
                      size: 32, color: Colors.green),
                ),
                Text(
                  widget.items[index]['label'],
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}