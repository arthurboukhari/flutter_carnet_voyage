import 'package:flutter/material.dart';
import 'package:flutter_carnet_voyage/models/contact.dart';

class SearchBar extends StatelessWidget {
  List<Contact> contacts;
  SearchBar({required this.contacts, super.key});

  String searchText = '';
  List<String> filteredItems = [];

  void filterSearchResults(String query) {
    List<Contact> searchList = [];
    searchList.addAll(contacts);
    
    if (query.isNotEmpty) {
      List<Contact> tempList = [];
      for (int i = 0; i < searchList.length; i++) {
        if (searchList[i].username.toLowerCase().contains(query.toLowerCase())) {
          tempList.add(searchList[i]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
    );
  }
}
