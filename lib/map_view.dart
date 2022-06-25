import 'package:flutter/material.dart';
import 'package:norway_map/config.dart';
import 'package:norway_map/map_provider.dart';
import 'package:provider/provider.dart';
import 'package:webviewx/webviewx.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key, required this.mapSource}) : super(key: key);

  final MapSource mapSource;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  late WebViewXController webviewController;
  @override
  Widget build(BuildContext context) {
    return WebViewX(
      width: double.maxFinite,
      height: double.maxFinite,
      initialContent: widget.mapSource
          .getUrl(Provider.of<MapProvider>(context, listen: false).loc),
      onWebViewCreated: (controller) {
        // controller.clearCache();
        webviewController = controller;
      },
    );
    // return WebView(
    //   initialUrl: widget.mapSource
    //       .getUrl(Provider.of<MapProvider>(context, listen: false).loc),
    // );
  }
}
