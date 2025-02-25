import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class LoadLiveStreamWidget extends StatefulWidget {
  const LoadLiveStreamWidget({
    super.key,
    required this.title,
    required this.height,
    required this.width,
    required this.url,
  });
  final String title;
  final String url;
  final double height;
  final double width;

  @override
  State<LoadLiveStreamWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoadLiveStreamWidget> {
  late WebViewXController webviewController;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  String _getEmbedUrl(String url) {
    if (url.contains('youtube.com/watch')) {
      final videoId = Uri.parse(url).queryParameters['v'];
      return 'https://www.youtube.com/embed/$videoId';
    } else if (url.contains('youtu.be/')) {
      final videoId = url.split('/').last;
      return 'https://www.youtube.com/embed/$videoId';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title),
      onExpansionChanged: (bool expanded) {
        setState(() {
          isExpanded = expanded;
        });
      },
      children: [
        if (isExpanded)
          if (widget.url.contains('youtube'))
            WebViewX(
              key: UniqueKey(),
              initialContent: _getEmbedUrl(widget.url),
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) {
                webviewController = controller;
              },
              webSpecificParams: const WebSpecificParams(
                webAllowFullscreenContent: true,
              ),
              width: widget.width,
              height: widget.height,
            )
          else
            WebViewX(
              key: UniqueKey(),
              initialContent: widget.url,
              initialSourceType: SourceType.url,
              onWebViewCreated: (controller) {
                webviewController = controller;
              },
              webSpecificParams: const WebSpecificParams(
                webAllowFullscreenContent: true,
              ),
              width: widget.width,
              height: widget.height,
            ),
      ],
    );
  }
}
