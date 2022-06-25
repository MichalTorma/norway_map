import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:norway_map/loc.dart';

class Config {
  var sources = List<MapSource>.empty(growable: true);
  loadConfigFromAssets() async {
    var configJsonString = await rootBundle.loadString('assets/config.json');
    var configJson = jsonDecode(configJsonString);
    fromJson(configJson);
  }

  fromJson(dynamic json) {
    sources = [];
    for (var mapSourceJson in json) {
      var ms = MapSource();
      ms.fromJson(mapSourceJson);
      sources.add(ms);
    }
  }
}

class MapSource {
  late String url;
  late String icon;
  fromJson(dynamic json) {
    url = json['url'];
    icon = json['icon'];
    return this;
  }

  String getUrl(Loc location) {
    var fullUrl = url.replaceFirst('{%LAT}', location.latitude.toString());
    fullUrl = fullUrl.replaceFirst('{%LON}', location.longitude.toString());
    fullUrl = fullUrl.replaceFirst('{%Z}', location.zoom.toString());
    print(fullUrl);
    return fullUrl;
  }
}
