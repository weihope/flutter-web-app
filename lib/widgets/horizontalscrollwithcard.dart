import 'package:app2/widgets/imageborderradius.dart';
import 'package:flutter/material.dart';

class HorizontalScrollWithCardWidget extends StatefulWidget {
  const HorizontalScrollWithCardWidget({
    super.key,
    required this.title,
    required this.thisWidgetHeight,
    required this.imageList,
  });
  final String title;
  final double thisWidgetHeight;
  final List<String> imageList;

  @override
  State<HorizontalScrollWithCardWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HorizontalScrollWithCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: widget.thisWidgetHeight * 0.7,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.imageList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: widget.thisWidgetHeight * 0.55,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: ConstrainedBox(
                                    constraints: const BoxConstraints.tightFor(
                                        width: 200, height: 200),
                                    child: Center(
                                      child: Text('click on Image $index'),
                                    ),
                                  ));
                                });
                          },
                          child: ImageBorderRadiusWidget(
                              imageUrl: widget.imageList[index]),
                        ),
                      ),
                      Text('Image $index'),
                    ],
                  ));
            },
          ),
        ),
      ],
    );
  }
}