import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  String searchText = '';

  List<String> items = [
    'Titre 1',
    'Titre 2',
    'Titre 3',
    'Titre 4',
    'Titre 5',
  ];

  List<String> filteredItems = [];

  void filterSearchResults(String query) {
    List<String> searchList = [];
    searchList.addAll(items);

    if (query.isNotEmpty) {
      List<String> tempList = [];
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].toLowerCase().contains(query.toLowerCase())) {
          tempList.add(searchList[i]);
        }
      }
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(tempList);
      });
      return;
    } else {
      setState(() {
        filteredItems.clear();
        filteredItems.addAll(items);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
