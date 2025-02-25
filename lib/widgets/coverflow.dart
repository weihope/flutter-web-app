import 'package:flutter/material.dart';

class CoverFlowWidget extends StatefulWidget {
  const CoverFlowWidget({
    super.key,
    required this.imageList,
  });
  final List<String> imageList;

  @override
  State<CoverFlowWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CoverFlowWidget> {
  final PageController _controller =
      PageController(viewportFraction: 0.7); // 控制可视比例

  @override
  void initState() {
    super.initState();

    // 等待第一帧渲染后执行动画
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.imageList.length > 1) {
        // 自动跳到 index 1
        _controller.jumpToPage(1);

        // 延迟一段时间，再返回 index 0
        await Future.delayed(const Duration(milliseconds: 300));
        _controller.animateToPage(
          0,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.imageList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              double value = 1.0;
              if (_controller.hasClients &&
                  _controller.position.haveDimensions) {
                //Null-aware operator
                value =
                    (_controller.page ?? _controller.initialPage.toDouble()) -
                        index;
                value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
              }
              return Center(
                child: Transform.scale(
                  scale: value,
                  child: child,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(widget.imageList[index], fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}