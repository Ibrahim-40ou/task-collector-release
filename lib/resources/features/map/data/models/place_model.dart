import 'package:tasks_collector/resources/features/map/domain/entities/place_entity.dart';

class PlaceModel extends PlaceEntity {
  PlaceModel({
    required super.placeName,
    required super.placeID,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      placeName: json['structured_formatting']['main_text'],
      placeID: json['place_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'place_name' : placeName,
      'place_id' : placeID,
    };
  }
}
