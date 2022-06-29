import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:norway_map/loc.dart';
import 'package:webviewx/webviewx.dart';

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
  late String name;
  late bool url_bypass;
  late WebViewXController webViewController;
  fromJson(dynamic json) {
    url = json['url'];
    icon = json['icon'];
    name = json['name'];
    url_bypass = json['url_bypass'];
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

// {
//         "url": "https://norgeibilder.no/?x=149265&y=6762961&level=7&utm=33&projects=&layers=&plannedOmlop=0&plannedGeovekst=0",
//         "icon": "https://ut.no/favicon.ico",
//         "name": "Norge i bilder",
//         "url_bypass": true
//     },
//     {
//         "url": "https://kart.finn.no/?lng={%LON}&lat={%LAT}&zoom={%Z}&mapType=normap",
//         "icon": "https://ut.no/favicon.ico",
//         "name": "FINN kart",
//         "url_bypass": true
//     },