import 'package:flutter_carnet_voyage/models/contact.dart';

import '../models/data_state.dart';

class ContactState {
  DataState dataState;
  List<Contact> contacts;
  List<Contact> ?filteredContact;
  
  ContactState(this.dataState, [this.contacts = const [], this.filteredContact = const []]);

  factory ContactState.loading() => ContactState(DataState.loading);

  factory ContactState.loaded(List<Contact> contacts, List<Contact>? filteredContact) =>
  ContactState(DataState.loaded, contacts, filteredContact);

  factory ContactState.error() => ContactState(DataState.error);

}
