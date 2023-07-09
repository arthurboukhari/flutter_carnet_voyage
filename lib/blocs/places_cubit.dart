import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/place.dart';
import '../repositories/place_repository.dart';
import 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit(this.placesRepository) : super(PlacesState.loading());

  final PlaceRepository placesRepository;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> loadPlaces() async {
    try {
      emit(PlacesState.loading());
      final String? userId = auth.currentUser?.uid;
      if (userId == null) {
        print('Utilisateur non connecté');
        return;
      }
      final places = await placesRepository.fetchRandomPlaces();
      final placesVisited = await placesRepository.fetchVisitedPlaces(userId);
      places.map((place) => place.visited = placesVisited.contains(place) ? true : false);
      final topRated = List<Place>.from(places);
      topRated.sort((a, b) => b.rating!.compareTo(a.rating as num));
      emit(PlacesState.loaded(places, topRated, placesVisited, null));
    } catch (e) {
      print(e);
      emit(PlacesState.error());
    }
  }

  Future<void> searchPlaceById(String placeId) async {
    try {
      Place placeFromSearch = await placesRepository.getPlaceById(placeId);
      emit(PlacesState.loaded(state.places, state.topRated, state.visited, placeFromSearch));
    } catch (e) {
      print(e);
      emit(PlacesState.error());
    }
  }

  Future<void> addPlaceToVisited(Place place) async {
    final String? userId = auth.currentUser?.uid;
    if (userId == null) {
      print('Utilisateur non connecté');
      return;
    }
    try {
      place.dateVisited = DateTime.now();
      place.visited = true;
      await placesRepository.addPlaceToVisited(userId, place);
      List<Place> updatedPlaces = List<Place>.from(state.places);
      int index = updatedPlaces.indexWhere((element) => element.id == place.id);
      updatedPlaces[index].visited = true;
      state.visited.add(updatedPlaces[index]);
      emit(PlacesState.loaded(updatedPlaces, state.topRated, state.visited, null));
    } catch (e) {
      print(e);
      emit(PlacesState.error());
    }
  }
}
