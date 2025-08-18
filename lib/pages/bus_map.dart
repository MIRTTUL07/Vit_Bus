import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BusMapPage extends StatefulWidget {
  final String trackingUrl;
  final String busNumber;

  const BusMapPage({
    super.key,
    required this.trackingUrl,
    required this.busNumber,
  });

  @override
  State<BusMapPage> createState() => _BusMapPageState();
}

class _BusMapPageState extends State<BusMapPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() => _isLoading = false);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.trackingUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Tracking - Bus ${widget.busNumber}'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
              ),
            ),
        ],
      ),
    );
  }
}
