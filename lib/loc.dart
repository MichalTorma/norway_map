import 'dart:html';

class Loc {
  late double latitude;
  late double longitude;
  late double zoom;
  Loc({
    required this.latitude,
    required this.longitude,
    required this.zoom,
  });

  @override
  bool operator ==(Object other) {
    if (other.runtimeType == Loc) {
      other = other as Loc;
      if (other.latitude == latitude &&
          other.longitude == longitude &&
          other.zoom == zoom) {
        return true;
      }
    }

    return false;
  }

  @override
  int get hashCode => (latitude * longitude * zoom).hashCode;
}
