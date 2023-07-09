import 'package:flutter_carnet_voyage/models/place.dart';

import '../models/data_state.dart';

class PlacesState {
  DataState dataState;
  List<Place> places;
  List<Place> topRated;
  List<Place> visited;
  Place? placeFromSearch;

  PlacesState(this.dataState, [this.places = const [], this.topRated = const [], this.visited = const [], this.placeFromSearch]);

  factory PlacesState.loading() => PlacesState(DataState.loading);

  factory PlacesState.loaded(List<Place> places, List<Place> topRated, List<Place> visited, Place? placeFromSearch) =>
      PlacesState(DataState.loaded, places, topRated, visited, placeFromSearch);

  factory PlacesState.error() => PlacesState(DataState.error);
}
