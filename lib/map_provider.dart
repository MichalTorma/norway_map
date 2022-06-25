import 'package:flutter/material.dart';
import 'package:norway_map/config.dart';
import 'package:norway_map/loc.dart';

class MapProvider extends ChangeNotifier {
  final _config = Config();
  bool _isLoading = true;
  var _loc = Loc(
    latitude: 61.8377,
    longitude: 8.5684,
    zoom: 11,
  );

  init() async {
    await _config.loadConfigFromAssets();
    _isLoading = false;
    notifyListeners();
  }

  set changeLoc(Loc newLoc) {
    if (newLoc != _loc) {
      _loc = newLoc;
      notifyListeners();
    }
  }

  Loc get loc => _loc;
  Config get config => _config;
  bool get isLoading => _isLoading;
}
