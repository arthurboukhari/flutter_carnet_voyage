import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carnet_voyage/blocs/places_cubit.dart';
import 'package:flutter_carnet_voyage/blocs/places_state.dart';
import 'package:flutter_carnet_voyage/repositories/place_repository.dart';
import 'package:flutter_carnet_voyage/ui/screens/place_card.dart';

import '../../models/data_state.dart';

class PlaceList extends StatefulWidget {
  const PlaceList({super.key});

  @override
  State<PlaceList> createState() => _PlaceListState();
}

class _PlaceListState extends State<PlaceList> {
  final placeRepository = PlaceRepository();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<PlacesCubit>().loadPlaces();
    return SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
              body: RefreshIndicator(
              onRefresh: () => context.read<PlacesCubit>().loadPlaces(),
              child: BlocBuilder<PlacesCubit, PlacesState>(
              builder: (context, state) {
                print(state.places.length);
                switch (state.dataState) {
              case DataState.loading:
                return SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child:
                const Center(child: CircularProgressIndicator()));
              case DataState.loaded:
                return Padding(
                  padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 24),
                  child: ListView.builder(
                    itemCount: state.places.length,
                      itemBuilder: (BuildContext context, index) {
                        
                    return PlaceCard(place: state.places[index]);
                  }),
                );
              case DataState.error:
                return const Center(
                  child: Text(
              'Une erreur est survenue, veuillez recommencer'),
                );
                }
              }),
              )
          ),
        )
    );
  }
}
