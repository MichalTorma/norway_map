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

class _MapViewState extends State<MapView>
    with AutomaticKeepAliveClientMixin<MapView> {
  late WebViewXController webviewController;
  @override
  Widget build(BuildContext context) {
    var bypass =
        widget.mapSource.url_bypass ? SourceType.urlBypass : SourceType.url;
    return WebViewX(
      width: double.maxFinite,
      height: double.maxFinite,
      initialSourceType: bypass,
      initialContent: widget.mapSource
          .getUrl(Provider.of<MapProvider>(context, listen: false).loc),
      onWebViewCreated: (controller) {
        // controller.clearCache();
        webviewController = controller;
        Provider.of<MapProvider>(context, listen: false).webViewXController =
            controller;
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
