import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart';
import "package:latlong2/latlong.dart";
import 'package:provider/provider.dart';
import 'package:http/retry.dart';
// import 'package:http/src/client.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: Provider.of<MapController>(context, listen: false),
      options: MapOptions(
          crs: const Epsg3857(),
          center: LatLng(61.8377, 8.5684),
          zoom: 11,
          pinchZoomThreshold: 1,
          plugins: []),
      layers: [
        TileLayerOptions(
            urlTemplate: 'assets/map/{z}/{x}/{y}.png',
            tileProvider: const AssetTileProvider()),
        TileLayerOptions(
            tileProvider: NetworkTileProvider(
                retryClient: RetryClient(
              Client(),
              retries: 10,
              when: (p0) => p0.headers['content-type'] != 'image/png',
            )),
            wmsOptions: WMSTileLayerOptions(
                baseUrl: 'https://openwms.statkart.no/skwms1/wms.topo4?',
                layers: ['topo4_WMS'],
                version: '1.3.0',
                format: 'image/png',
                crs: const Epsg3857(),
                transparent: false)),
      ],
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: 'GeoNorge - Norgeskart (CC BY 4.0)',
          onSourceTapped: null,
        ),
      ],
    );
  }
}
