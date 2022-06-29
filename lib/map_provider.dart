import 'package:flutter/material.dart';
import 'package:norway_map/config.dart';
import 'package:norway_map/loc.dart';
import 'package:webviewx/webviewx.dart';

class MapProvider extends ChangeNotifier {
  final _config = Config();
  bool _isLoading = true;
  late MapTab _activeMapTab;
  List<MapTab> _mapTabs = List<MapTab>.empty();
  int _activeIndex = 0;
  var _loc = Loc(
    latitude: 61.8377,
    longitude: 8.5684,
    zoom: 11,
  );

  Future init({Loc? initialLoc}) async {
    if (initialLoc != null) {
      _loc = initialLoc;
    }
    await _config.loadConfigFromAssets();
    _mapTabs = _config.sources.map((e) => MapTab(e)).toList();
    _activeMapTab = _mapTabs[_activeIndex];
    _isLoading = false;
    notifyListeners();
  }

  Future changeTab(int index) async {
    if (_activeIndex != index) {
      _activeIndex = index;
      _activeMapTab = _mapTabs[_activeIndex];
    }
  }

  reload() {
    _activeMapTab.webViewXController.reload();
  }

  set changeLoc(Loc newLoc) {
    if (newLoc != _loc) {
      _loc = newLoc;
      notifyListeners();
    }
  }

  set webViewXController(WebViewXController controller) {
    _activeMapTab.webViewXController = controller;
    _mapTabs[_activeIndex].webViewXController = controller;
  }

  Loc get loc => _loc;
  bool get isLoading => _isLoading;
  Config get config => _config;
}

class MapTab {
  final MapSource mapSource;
  late WebViewXController webViewXController;

  MapTab(this.mapSource);
}
