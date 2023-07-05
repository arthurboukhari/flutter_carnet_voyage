import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/place.dart';

class PlaceRepository {
  final apiKey = 'AIzaSyAmyJ1AaFE0QT7PSJ9hqqGmKyGH_mQCXPA';

  Future<List<Place>> fetchRandomPlaces() async {
    final placesApiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=48.8566,2.3522&radius=50000&type=point_of_interest&key=$apiKey';

    try {
      final response = await http.get(
        Uri.parse(placesApiUrl),
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'GET',
          "x-requested-with": "XMLHttpRequest"
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;

        return results.map((place) {
          Place p = Place.fromGoogleJson(place);
          if(p.photoReference != null) {
            p.photoUrl = getPhotoUrl(p.photoReference as String);
          }
          return p;
          }).toList();
      } else {
        throw Exception(
          'Erreur lors de la récupération des lieux : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP : $error');
    }
  }

  String getPhotoUrl(String photoReference) {
    var photoUrl =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
        print(photoUrl);
    return photoUrl;
  }
}
