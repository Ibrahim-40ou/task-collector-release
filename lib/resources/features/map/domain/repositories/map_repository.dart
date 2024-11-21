abstract class MapRepository {
  Future<void> fetchPlaces(String placeName);
  Future<void> fetchLatLng(String placeID);
}