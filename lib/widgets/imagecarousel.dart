import 'dart:async';
import 'package:app2/widgets/imageborderradius.dart';
import 'package:flutter/material.dart';

class ImageCarouselWidget extends StatefulWidget {
  const ImageCarouselWidget({
    super.key,
    required this.height,
    required this.width,
    required this.isMobile,
    required this.imageList,
  });
  final double height;
  final double width;
  final bool isMobile;
  final List<String> imageList;

  @override
  State<ImageCarouselWidget> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarouselWidget> {
  final PageController _controller = PageController();

  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < widget.imageList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: widget.imageList.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            itemBuilder: (context, index) {
              return ImageBorderRadiusWidget(
                imageUrl: widget.imageList[index],
              );
            },
          ),
          if (widget.isMobile) ...[
            Positioned(
              left: 10,
              child: GestureDetector(
                onTap: () {
                  if (_currentPage > 0) {
                    _currentPage--;
                    _controller.animateToPage(
                      _currentPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 30,
                ),
              ),
            ),
            Positioned(
              right: 10,
              child: GestureDetector(
                onTap: () {
                  if (_currentPage < widget.imageList.length - 1) {
                    _currentPage++;
                    _controller.animateToPage(
                      _currentPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white.withOpacity(0.8),
                  size: 30,
                ),
              ),
            ),
          ],
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.imageList.length,
                  (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentPage = index;
                        _controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}