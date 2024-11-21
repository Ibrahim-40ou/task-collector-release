part of 'map_functionality_bloc.dart';

@immutable
sealed class MapFEvents {}

class FetchPlaces extends MapFEvents {
  final String placeName;

  FetchPlaces({required this.placeName});
}
