import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../values/colors.dart';
import 'base_app_bar.dart';

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({
    required this.title,
    required this.url,
    super.key,
  });

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _isLoadingPage = true;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (finish) {
            setState(() {
              _isLoadingPage = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        leadingIcon: true,
        showTitle: true,
        title: widget.title,
        backgroundColor: AppColor.white,
        leadingWidgetColor: AppColor.black,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoadingPage)
              const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}

