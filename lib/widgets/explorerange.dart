import 'package:app2/widgets/popupmenu.dart';
import 'package:flutter/material.dart';

class ExploreRangeWidget extends StatefulWidget {
  const ExploreRangeWidget({
    super.key,
    required this.imageList,
  });
  final List<String> imageList;

  @override
  State<ExploreRangeWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ExploreRangeWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Explore Our Range',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final double itemWidth = (constraints.maxWidth - 8) / 2;

              // 分成两列
              List<String> leftColumn = [];
              List<String> rightColumn = [];

              for (int i = 0; i < widget.imageList.length; i++) {
                if (i.isEven) {
                  leftColumn.add(widget.imageList[i]);
                } else {
                  rightColumn.add(widget.imageList[i]);
                }
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 左列
                  Expanded(
                    child: Column(
                      children: List.generate(leftColumn.length, (index) {
                        return InkWell(
                          onTap: () {
                            _showImageDialog(context, leftColumn[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                leftColumn[index],
                                fit: BoxFit.cover,
                                width: itemWidth,
                                height: 250,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // 右列
                  Expanded(
                    child: Column(
                      children: List.generate(rightColumn.length, (index) {
                        return Builder(builder: (innerContext) {
                          return InkWell(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              width: itemWidth,
                              height: index == 0 ? 200 : 250,
                              child: PopUpMenuWidget(
                                imageUrl: rightColumn[index],
                              ),
                              // ClipRRect(
                              //   borderRadius: BorderRadius.circular(8),
                              //   child: Image.network(
                              //     rightColumn[index],
                              //     fit: BoxFit.cover,
                              //     width: itemWidth,
                              //     height: index == 0 ? 200 : 250,
                              //   ),
                              // ),
                            ),
                          );
                        });
                      }),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8), // 背景变暗
      barrierDismissible: true, // 点击外部关闭
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Material(
            color: Colors.transparent,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain, // 保持比例展示图片
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
        );
      },
    );
  }

  // void _showImageOverlay(
  //     BuildContext context, String imageUrl, RenderBox renderBox) {
  //   final overlay = Overlay.of(context);
  //   final position = renderBox.localToGlobal(Offset.zero);
  //   final screenSize = MediaQuery.of(context).size;

  //   late OverlayEntry overlayEntry;

  //   overlayEntry = OverlayEntry(
  //     builder: (context) => Stack(
  //       children: [
  //         // 背景变暗
  //         GestureDetector(
  //           onTap: () => overlayEntry.remove(),
  //           child: Container(
  //             color: Colors.black.withOpacity(0.8),
  //           ),
  //         ),
  //         // 图片在点击的位置放大，且根据屏幕比例调整大小
  //         Positioned(
  //           top: position.dy,
  //           left: position.dx *0.8,
  //           child: Hero(
  //             tag: imageUrl,
  //             child: Material(
  //               color: Colors.transparent,
  //               child: ClipRRect(
  //                 borderRadius: BorderRadius.circular(8),
  //                 child: Image.network(
  //                   imageUrl,
  //                   fit: BoxFit.contain,
  //                   width: screenSize.width * 0.8, // 占屏幕宽度80%
  //                   height: screenSize.height * 0.6, // 占屏幕高度60%
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );

  //   overlay?.insert(overlayEntry);
  // }
}