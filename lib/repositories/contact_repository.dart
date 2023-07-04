import 'package:flutter/cupertino.dart';
import '../models/contact.dart';



class ContactRepository {
  List<Contact> _contacts = [
    Contact(id: '1', username: 'John Doe', description: '1234567890'),
    Contact(id: '2', username: 'Jane Smith', description: '0987654321'),
    Contact(id: '3', username: 'Bob Johnson', description: '9876543210'),
  ];

  List<Contact> getContacts() {
    return _contacts;
  }

  void addContact(Contact contact) {
    _contacts.add(contact);
  }

  void updateContact(Contact contact) {
    int contactIndex = _contacts.indexWhere((c) => c.id == contact.id);
    if (contactIndex != -1) {
      _contacts[contactIndex] = contact;
    }
  }

  void deleteContact(String id) {
    _contacts.removeWhere((contact) => contact.id == id);
  }
}
