
class Place {
  final String? id;
  final String? googleId;
  final String name;
  final String icon;
  final String? photoReference;
  late String? photoUrl;
  final double? rating;
  final Location location;
  bool visited;

  Place({this.id, this.googleId, this.rating, required this.name, required this.icon, required this.photoReference, required this.location, this.visited = false, this.photoUrl});

  factory Place.fromGoogleJson(Map<String, dynamic> json) {
    print(json);
    return Place(
      googleId: json['place_id'],
      name: json['name'],
      icon: json['icon'],
      rating: json['rating'],
      location: Location.fromJson(json['geometry']['location']),
      photoReference: json['photos'][0]['photo_reference']
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'googleId': googleId,
      'name': name,
      'photoReference' : photoReference,
      "photoUrl": photoUrl,
      'icon': icon,
      'rating': rating,
      'location': {
        'latitude': location.latitude,
        'longitude': location.longitude,
        'address' : location.address
      },
      'visited': visited,
    };
  }

  factory Place.fromDatabaseJson(Map<String, dynamic> json) {
    return Place(
      id: json['id'],
      googleId: json['googleId'],
      name: json['name'],
      photoReference: json['photoReference'],
      photoUrl: json['photoUrl'],
      icon: json['icon'],
      rating: json['rating'],
      location: Location(
        latitude: json['location']['latitude'],
        longitude: json['location']['longitude'],
        address: json['location']['address'],
      ),
      visited: json['visited']
    );
  }
}

class Location {
  final double latitude;
  final double longitude;
  final String address;
  const Location({required this.latitude, required this.longitude, required this.address});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['lat'],
      longitude: json['lng'],
      address: json['vicinity'] ?? "",
    );
  }
}