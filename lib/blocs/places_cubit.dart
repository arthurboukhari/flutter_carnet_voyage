import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/place.dart';
import '../repositories/place_repository.dart';
import 'places_state.dart';

class PlacesCubit extends Cubit<PlacesState> {
  PlacesCubit(this.placesRepository) : super(PlacesState.loading());

  final PlaceRepository placesRepository;

  Future<void> loadPlaces() async {
    try {
      emit(PlacesState.loading());
      final places = await placesRepository.fetchRandomPlaces();
      final topRated = List<Place>.from(places);
      topRated.sort((a, b) => b.rating!.compareTo(a.rating as num));
      emit(PlacesState.loaded(places, topRated, []));
    } catch (e) {
      print(e);
      emit(PlacesState.error());
    }
  }
}