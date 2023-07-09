import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../models/place.dart';

class PlaceRepository {
  final apiKey = 'AIzaSyAmyJ1AaFE0QT7PSJ9hqqGmKyGH_mQCXPA';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> citiesLocation = [
    {"name": "Paris", "lat": 48.8566, "lng": 2.3522},
    {"name": "Marseille", "lat": 43.2965, "lng": 5.3698},
    {"name": "Lyon", "lat": 45.75, "lng": 4.85},
    {"name": "Toulouse", "lat": 43.6047, "lng": 1.4442},
    {"name": "Nice", "lat": 43.7031, "lng": 7.2661},
    {"name": "Nantes", "lat": 47.2184, "lng": -1.5536},
    {"name": "Strasbourg", "lat": 48.5734, "lng": 7.7521},
    {"name": "Montpellier", "lat": 43.6107, "lng": 3.8767},
    {"name": "Bordeaux", "lat": 44.8378, "lng": -0.5792},
    {"name": "Lille", "lat": 50.6292, "lng": 3.0573},
    {"name": "Rennes", "lat": 48.1173, "lng": -1.6778},
    {"name": "Reims", "lat": 49.2583, "lng": 4.0317},
    {"name": "Saint-Étienne", "lat": 45.4397, "lng": 4.3872},
    {"name": "Toulon", "lat": 43.1257, "lng": 5.9305},
    {"name": "Le Havre", "lat": 49.4939, "lng": 0.1080},
    {"name": "Cergy-Pontoise", "lat": 49.0356, "lng": 2.0600},
    {"name": "Angers", "lat": 47.4784, "lng": -0.5632},
    {"name": "Grenoble", "lat": 45.1885, "lng": 5.7245},
    {"name": "Dijon", "lat": 47.3220, "lng": 5.0415},
    {"name": "Nîmes", "lat": 43.8367, "lng": 4.3601},
  ];

  /**
   * Récupère une ville parmis les 20 plus grosses villes françaises puis récupère 20 lieux de cette ville avec l'API Google Places
   */
  Future<List<Place>> fetchRandomPlaces() async {
    final rng = Random();
    final randomCity = citiesLocation[rng.nextInt(19)];
    final placesApiUrl =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${randomCity['lat']},${randomCity['lng']}&radius=5000&type=point_of_interest&key=$apiKey';

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
          if (p.photoReference != null) {
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

  /**
   * Récupèrent tous les détails d'un lieu avec l'API Google Place
   */
  Future<Place> getPlaceById(String placeId) async {
    final placesApiUrl =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey";

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
        final result = data['result'] as Map<String, dynamic>;
        Place place = Place.fromGoogleJson(result);
        if (place.photoReference != null) {
          place.photoUrl = getPhotoUrl(place.photoReference as String);
        }
        return place;
      } else {
        throw Exception(
            'Erreur lors de la récupération des detail du lieu : ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Erreur lors de la requête HTTP : $error');
    }
  }

  /**
   * Récupère l'URL d'une photo correspondante à un lieu avec l'API Google Place
   */
  String getPhotoUrl(String photoReference) {
    var photoUrl =
        'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoReference&key=$apiKey';
    return photoUrl;
  }

    Future<List<Place>> fetchVisitedPlaces(String userId) async {
    try {
      QuerySnapshot snapshot = await firestore.collection('users').doc(userId).collection('visitedPlaces').get();
      return snapshot.docs.map((doc) => Place.fromDatabaseJson(doc.data() as Map<String, dynamic>)).toList();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> addPlaceToVisited(String userId, Place place) async {
    try {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('visitedPlaces')
          .doc(place.googleId)
          .set(place.toJson());
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
