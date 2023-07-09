import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carnet_voyage/blocs/places_cubit.dart';
import 'package:flutter_carnet_voyage/blocs/places_state.dart';
import 'package:flutter_carnet_voyage/repositories/place_repository.dart';
import 'package:flutter_carnet_voyage/ui/screens/widgets/place_card.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../blocs/user_cubit.dart';
import '../../models/data_state.dart';

enum DisplayType { discover, visited, topRated, search }

class PlaceList extends StatefulWidget {
  const PlaceList({super.key});

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  final placeRepository = PlaceRepository();
  final ValueNotifier<DisplayType> _displayTypeNotifier =
      ValueNotifier<DisplayType>(DisplayType.discover);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  int getItemCount(PlacesState placeState){
    switch(_displayTypeNotifier.value){
      case(DisplayType.discover):
        return placeState.places.length;
      case(DisplayType.topRated):
        return placeState.topRated.length;
      case(DisplayType.visited):
        return placeState.visited.length;
      case(DisplayType.search):
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<PlacesCubit>().loadPlaces();
    final TextEditingController searchController = TextEditingController();
    return SafeArea(
        child: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 250, 250, 250),
              foregroundColor: Colors.black,
              elevation: 0,
              title: GooglePlaceAutoCompleteTextField(
                  textEditingController: searchController,
                  googleAPIKey: "AIzaSyAmyJ1AaFE0QT7PSJ9hqqGmKyGH_mQCXPA",
                  inputDecoration:
                      InputDecoration(hintText: "Rechercher un lieu..."),
                  debounceTime: 800,
                  getPlaceDetailWithLatLng: (Prediction prediction) {},
                  itmClick: (Prediction prediction) {
                    searchController.text = prediction.description!;
                    searchController.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length));
                    context
                        .read<PlacesCubit>()
                        .searchPlaceById(prediction.placeId!);
                  })),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Center(
                      child: Text(
                    'Mon carnet de voyage',
                    style: TextStyle(color: Colors.white),
                  )),
                ),
                ListTile(
                  leading: Icon(Icons.place),
                  title: const Text('Découvrir des lieux'),
                  onTap: () => _displayTypeNotifier.value = DisplayType.discover,
                ),
                ListTile(
                  leading: Icon(Icons.run_circle_rounded),
                  title: const Text('Mes dernières visites'),
                  onTap: () => _displayTypeNotifier.value = DisplayType.visited,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Se déconnecter'),
                  onTap: () => context.read<UserCubit>().logout(),
                ),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<PlacesCubit>().loadPlaces(),
            child: BlocBuilder<PlacesCubit, PlacesState>(
                builder: (context, state) {
              switch (state.dataState) {
                case DataState.loading:
                  return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const Center(child: CircularProgressIndicator()));
                case DataState.loaded:
                  return ValueListenableBuilder<DisplayType>(
                    valueListenable: _displayTypeNotifier,
                    builder: (context, displayType, child) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        child: ListView.builder(
                            itemCount: getItemCount(state),
                            itemBuilder: (BuildContext context, index) {
                              switch (displayType) {
                                case DisplayType.discover:
                                  return PlaceCard(
                                    place: state.places[index]
                                  );
                                case DisplayType.visited:
                                    return PlaceCard(
                                    place: state.visited[index]
                                  );
                                case DisplayType.topRated:
                                  return PlaceCard(
                                    place: state.topRated[index]
                                  );
                                case DisplayType.search:
                                  return PlaceCard(
                                    place: state.placeFromSearch!
                                  );
                              }
                            }),
                      );
                    },
                  );
                case DataState.error:
                  return const Center(
                    child:
                        Text('Une erreur est survenue, veuillez recommencer'),
                  );
              }
            }),
          )),
    ));
  }
}
