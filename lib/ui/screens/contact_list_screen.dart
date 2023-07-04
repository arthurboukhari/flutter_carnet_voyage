import 'dart:developer';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carnet_voyage/ui/screens/contact_card.dart';

import '../../models/contact.dart';
import '../../repositories/contact_repository.dart';
import 'components/search_bar.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  final ContactRepository _contactRepository = ContactRepository();
  List<Contact> _contacts = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchContacts();
  }

  void _fetchContacts() {
    setState(() {
      _contacts = _contactRepository.getContacts();
      print(_contacts);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child:  SearchBar(),
            ),
            Expanded(
              child: ListView.builder(itemCount: _contacts.length,itemBuilder: (BuildContext context, index,){
                return ContactCard(contact : _contacts[index]);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
