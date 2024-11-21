part of 'map_bloc.dart';

@immutable
sealed class MapStates {}

class MapInitial extends MapStates {}

class MapReady extends MapStates {}

class MapDisposed extends MapStates {}
