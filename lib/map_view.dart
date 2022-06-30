import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import "package:latlong2/latlong.dart";
import 'package:norway_map/crs.dart';
import 'package:provider/provider.dart';

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: Provider.of<MapController>(context, listen: false),
      options: MapOptions(
        // crs: Proj4Crs.fromFactory(code: code, proj4Projection: proj4Projection),
        crs: epsg4273(),
        // crs: Proj4Crs.fromFactory(code: '', proj4Projection: proj4Projection)
        center: LatLng(61.8377, 8.5684),
        zoom: 13,
      ),
      layers: [
        TileLayerOptions(
            wmsOptions: WMSTileLayerOptions(
          baseUrl: 'https://openwms.statkart.no/skwms1/wms.topo4?',
          layers: ['topo4_WMS'],
          version: '1.3.0',
          format: 'image/jpeg',
          crs: epsg4273(),
        )),
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
