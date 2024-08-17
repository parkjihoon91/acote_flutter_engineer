import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BannerScreen extends StatefulWidget {
  const BannerScreen({super.key});

  @override
  State<BannerScreen> createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  late WebViewController _webViewController;
  bool _isProgress = false;

  @override
  void initState() {
    super.initState();
    Uri _url = Uri.parse(
      'https://taxrefundgo.kr',
    );

    _webViewController = WebViewController();
    _webViewController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progressing $progress');
          },
          onPageStarted: (String url) {
            debugPrint(url);
          },
          onPageFinished: (String url) {
            debugPrint('Page Finished');
            setState(() {
              _isProgress = true;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(_url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if (!_isProgress) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ] else ...[
              WebViewWidget(
                controller: _webViewController,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
