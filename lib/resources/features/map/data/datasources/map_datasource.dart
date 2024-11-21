import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tasks_collector/resources/core/api/endpoints.dart';
import 'package:tasks_collector/resources/core/api/https_consumer.dart';
import 'package:tasks_collector/resources/core/api/keys.dart';
import 'package:tasks_collector/resources/core/utils/result.dart';
import 'package:tasks_collector/resources/features/map/data/models/place_model.dart';
import 'package:tasks_collector/resources/features/map/domain/entities/place_entity.dart';
import 'package:uuid/uuid.dart';

class MapDatasource {
  final HttpsConsumer httpsConsumer;

  MapDatasource({required this.httpsConsumer});

  Future<Result<List<PlaceEntity>>> fetchPlaces(String placeName) async {
    final String token = Uuid().v1();
    late List<PlaceEntity> places = [];
    final result = await httpsConsumer.get(
      endpoint:
          '${EndPoints.predictionsBaseURL}&input=$placeName&key=${APIKeys.predictions}&token=$token',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      isMapSearch: true,
    );
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);
      for (Map<String, dynamic> place in responseBody['predictions']) {
        places.add(PlaceModel.fromJson(place));
      }
      return Result<List<PlaceEntity>>(data: places);
    } else {
      return Result<List<PlaceEntity>>(error: result.error);
    }
  }

  Future<Result<LatLng>> fetchLatLng(String placeID) async {
    final result = await httpsConsumer.get(
      endpoint:
          '${EndPoints.predictionsDetailsBaseURL}?place_id=$placeID&key=${APIKeys.predictions}',
      headers: {
        'accept': 'application/json',
        'Content-Type': 'application/json'
      },
      isMapSearch: true,
    );
    if (result.isSuccess && result.data != null) {
      final responseBody = jsonDecode(result.data!.body);
      return Result<LatLng>(
        data: LatLng(
          responseBody['result']['geometry']['location']['lat'],
          responseBody['result']['geometry']['location']['lng'],
        ),
      );
    } else {
      return Result<LatLng>(error: result.error);
    }
  }
}
