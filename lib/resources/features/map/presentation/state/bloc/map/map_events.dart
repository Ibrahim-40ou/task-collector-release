part of 'map_bloc.dart';

@immutable
sealed class MapEvents {}

class InitializeMap extends MapEvents {
  final GoogleMapController mapController;

  InitializeMap(this.mapController);
}

class DisposeMap extends MapEvents {}

class Refresh extends MapEvents {}
