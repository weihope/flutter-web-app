import 'package:flutter/material.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

class WebViewXPlusScreen extends StatefulWidget {
  const WebViewXPlusScreen({super.key, required this.url});
  final String url;

  @override
  State<WebViewXPlusScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WebViewXPlusScreen> {
  late WebViewXController webviewController;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : WebViewX(
                initialContent: widget.url,
                initialSourceType: SourceType.urlBypass,
                onWebViewCreated: (controller) {
                  webviewController = controller;
                },
                webSpecificParams: const WebSpecificParams(
                  webAllowFullscreenContent: true,
                ),
                // onPageStarted: (_) => isLoading = false,
                onPageFinished: (url) {
                  setState(() {
                    isLoading = false; 
                  });
                },
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
    );
  }
}
