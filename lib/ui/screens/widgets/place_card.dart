import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carnet_voyage/blocs/places_cubit.dart';
import '../../../models/place.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  PlaceCard({required this.place});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/place-detail', arguments: place),
      child: Card(
        elevation: 2.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Image.network(
                place.photoUrl ??
                    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/800px-Image_not_available.png?20210219185637",
                height: 200.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          place.name,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (place.visited)
                        Chip(
                            label: Text("Visité",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                            backgroundColor: Color.fromARGB(166, 65, 255, 65))
                      else
                        Chip(
                            label: Text("Non visité",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic)),
                            backgroundColor: Color.fromARGB(255, 255, 4, 4))
                    ],
                  ),
                  SizedBox(height: 10.0),
                  if (place.rating != null)
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          index < place.rating! ? Icons.star : Icons.star_border,
                          color: Colors.yellow[700],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
