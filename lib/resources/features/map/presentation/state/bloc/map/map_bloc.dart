import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_events.dart';

part 'map_states.dart';

class MapBloc extends Bloc<MapEvents, MapStates> {
  GoogleMapController? mapController;

  MapBloc() : super(MapInitial()) {
    on<InitializeMap>(_initializeMap);
    on<DisposeMap>(_disposeMap);
    on<Refresh>(_refresh);
  }

  void _refresh(
      Refresh event,
      Emitter<MapStates> emit,
      ) {
    emit(MapReady());
  }

  void _initializeMap(
    InitializeMap event,
    Emitter<MapStates> emit,
  ) {
    mapController = event.mapController;
    emit(MapReady());
  }

  void _disposeMap(
    DisposeMap event,
    Emitter<MapStates> emit,
  ) {
    mapController?.dispose();
    mapController = null;
    emit(MapDisposed());
  }
}
