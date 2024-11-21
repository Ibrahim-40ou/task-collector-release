import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tasks_collector/resources/core/api/https_consumer.dart';
import 'package:tasks_collector/resources/core/services/internet_services.dart';
import 'package:tasks_collector/resources/core/utils/result.dart';
import 'package:tasks_collector/resources/features/map/data/datasources/map_datasource.dart';
import 'package:tasks_collector/resources/features/map/data/repositories/map_repository_impl.dart';
import 'package:tasks_collector/resources/features/map/domain/entities/place_entity.dart';
import 'package:tasks_collector/resources/features/map/domain/entities/place_information.dart';
import 'package:tasks_collector/resources/features/map/domain/use_cases/coordinates_use_case.dart';
import 'package:tasks_collector/resources/features/map/domain/use_cases/places_use_case.dart';

part 'map_functionality_events.dart';

part 'map_functionality_states.dart';

class MapFBloc extends Bloc<MapFEvents, MapFStates> {
  late List<PlaceEntity> places = [];
  late List<LatLng> coordinates = [];
  late List<PlaceInformation> placesInformation = [];

  MapFBloc() : super(MapFInitial()) {
    on<FetchPlaces>(_fetchPlaces);
  }

  Future<void> _fetchPlaces(
    FetchPlaces event,
    Emitter<MapFStates> emit,
  ) async {
    if (await InternetServices().isInternetAvailable()) {
      emit(PlacesFetchLoading());
      places.clear();
      coordinates.clear();
      placesInformation.clear();
      final Result placesResult = await FetchPlacesUseCase(
        mapRepositoryImpl: MapRepositoryImpl(
          mapDatasource: MapDatasource(
            httpsConsumer: HttpsConsumer(),
          ),
        ),
      ).call(event.placeName);
      if (placesResult.isSuccess) {
        places = placesResult.data;
      } else {
        return emit(PlacesFetchFailure(failure: placesResult.error!));
      }
      for (PlaceEntity place in places) {
        final Result coordinatesResult = await FetchCoordinatesUseCase(
          mapRepositoryImpl: MapRepositoryImpl(
            mapDatasource: MapDatasource(
              httpsConsumer: HttpsConsumer(),
            ),
          ),
        ).call(place.placeID);
        if (coordinatesResult.isSuccess) {
          coordinates.add(coordinatesResult.data);
        } else {
          return emit(PlacesFetchFailure(failure: coordinatesResult.error!));
        }
      }

      if (places.length == coordinates.length) {
        for (int i = 0; i < places.length; i++) {
          placesInformation.add(
            PlaceInformation(place: places[i], coordinates: coordinates[i]),
          );
        }
      } else {
        return emit(PlacesFetchFailure(failure: 'unknown error occurred.'));
      }
      return emit(PlacesFetched(placesInformation: placesInformation));
    } else {
      return emit(PlacesFetchFailure(failure: 'Network is unreachable'));
    }
  }
}
