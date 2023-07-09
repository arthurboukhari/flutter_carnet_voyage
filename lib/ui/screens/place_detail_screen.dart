import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../blocs/places_cubit.dart';
import '../../models/place.dart';

class PlaceDetail extends StatelessWidget {
  bool _visited = false;
  late Place place;
  late GoogleMapController mapController;
  PlaceDetail({super.key});

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null) {
      Navigator.pop(context);
    } else {
      place = args as Place;
    }
    final ValueNotifier<bool> _visitedNotifier =
        ValueNotifier<bool>(place.visited);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 300.0,
                    child: Image.network(
                      place.photoUrl ??
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Image_not_available.png/800px-Image_not_available.png?20210219185637",
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white, size: 32),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      place.name,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    if (place.rating != null)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                  children: List.generate(
                                5,
                                (index) => Icon(
                                  index < place.rating!
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.yellow[700],
                                ),
                              )),
                            ),
                            ValueListenableBuilder<bool>(
                              valueListenable: _visitedNotifier,
                              builder: (context, visited, child) {
                                return visited
                                    ? Chip(
                                        avatar: Icon(Icons.check,
                                            color: Colors.white),
                                        label: Text("Visité",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic)),
                                        backgroundColor:
                                            Color.fromARGB(166, 65, 255, 65))
                                    : InkWell(
                                        onTap: () async {
                                          try{
                                          await context.read<PlacesCubit>().addPlaceToVisited(place);
                                          _visitedNotifier.value = place.visited;
                                          } catch(e){}
                                        },
                                        child: Chip(
                                            avatar: Icon(Icons.close,
                                                color: Colors.white),
                                            label: Text("Non visité",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                )),
                                            backgroundColor:
                                                Color.fromARGB(255, 255, 4, 4)),
                                      );
                              },
                            ),
                          ]),
                    SizedBox(height: 20.0),
                    // GoogleMap(
                    //   initialCameraPosition: CameraPosition(
                    //     target: LatLng(place.location.latitude, place.location.longitude),
                    //     zoom: 14.4746,
                    //   ),
                    //   markers: {
                    //     Marker(
                    //       markerId: MarkerId(place.googleId ?? ""),
                    //       position: LatLng(place.location.latitude, place.location.longitude),
                    //     ),
                    //   },
                    // ),
                    SizedBox(height: 20.0),

                    // Ajoutez ici une section commentaire.
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
