import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebViewScreen extends StatefulWidget {
  const InAppWebViewScreen({super.key, required this.url});
  final String url;

  @override
  State<InAppWebViewScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InAppWebViewScreen> {
  InAppWebViewController? webViewController;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri(widget.url)),
                onWebViewCreated: (controller) async{
                  webViewController = controller;
                },
                onProgressChanged: (controller, progress) {
                  // setState(() {
                  //   isLoading = progress < 100; 
                  // });
                },
                onLoadStop: (controller, url) {
                  // setState(() {
                  //   isLoading = false;
                  // });
                },
              ),
    );
  }
}
