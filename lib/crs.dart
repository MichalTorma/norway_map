import 'package:flutter_map/plugin_api.dart';
import 'package:proj4dart/proj4dart.dart' as proj4;

// EPSG:4273
// +proj=longlat +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +no_defs
Crs epsg4273() {
  proj4.Projection epsg4273 = proj4.Projection.get('EPSG:4273') ??
      proj4.Projection.add('EPSG:4273',
          '+proj=longlat +a=6377492.018 +b=6356173.508712696 +towgs84=278.3,93,474.5,7.889,0.05,-6.61,6.21 +no_defs');

  // 9 example zoom level resolutions
  final resolutions = <double>[
    32768,
    16384,
    8192,
    4096,
    2048,
    1024,
    512,
    256,
    128,
  ];

  final epsg3413Bounds = Bounds<double>(
    const CustomPoint<double>(-4511619.0, -4511336.0),
    const CustomPoint<double>(4510883.0, 4510996.0),
  );

  // double maxZoom = (resolutions.length - 1).toDouble();

  // Define CRS
  return Proj4Crs.fromFactory(
    // CRS code
    code: 'EPSG:3413',
    // your proj4 delegate
    proj4Projection: epsg4273,
    // Resolution factors (projection units per pixel, for example meters/pixel)
    // for zoom levels; specify either scales or resolutions, not both
    resolutions: resolutions,
    // Bounds of the CRS, in projected coordinates
    // (if not specified, the layer's which uses this CRS will be infinite)
    bounds: epsg3413Bounds,
    // Tile origin, in projected coordinates, if set, this overrides the transformation option
    // Some goeserver changes origin based on zoom level
    // and some are not at all (use explicit/implicit null or use [CustomPoint(0, 0)])
    // @see https://github.com/kartena/Proj4Leaflet/pull/171
    origins: [const CustomPoint(0, 0)],
    // Scale factors (pixels per projection unit, for example pixels/meter) for zoom levels;
    // specify either scales or resolutions, not both
    scales: null,
    // The transformation to use when transforming projected coordinates into pixel coordinates
    transformation: null,
  );
}
