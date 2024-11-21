part of 'map_functionality_bloc.dart';

@immutable
sealed class MapFStates {}

class MapFInitial extends MapFStates {}

class PlacesFetchLoading extends MapFStates {}

class PlacesFetchFailure extends MapFStates {
  final String failure;

  PlacesFetchFailure({required this.failure});
}

class PlacesFetched extends MapFStates {
  final List<PlaceInformation> placesInformation;

  PlacesFetched({required this.placesInformation});
}

