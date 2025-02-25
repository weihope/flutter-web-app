import 'package:flutter/material.dart';

class ImageBorderRadiusWidget extends StatefulWidget {
  const ImageBorderRadiusWidget({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  State<ImageBorderRadiusWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ImageBorderRadiusWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        widget.imageUrl,
        fit: BoxFit.fill,
        // width: widget.width,
        // height: widget.height,
      ),
    );
  }
}
