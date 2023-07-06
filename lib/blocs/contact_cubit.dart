import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carnet_voyage/blocs/contact_state.dart';
import 'package:flutter_carnet_voyage/models/data_state.dart';
import '../models/contact.dart';
import '../repositories/contact_repository.dart';

class ContactCubit extends Cubit<ContactState> {
  final ContactRepository contactRepository;

  ContactCubit(this.contactRepository) : super(ContactState.loading());

  // Méthode pour filtrer les contacts
  void fetchContacts(){
    try {
      emit(ContactState.loading());
      final contacts = contactRepository.getContacts();
      emit(ContactState.loaded(contacts, null));
    } catch (e) {
      emit(ContactState.error());
    }
  }
  void filterContacts(String searchTerm) {
    if (searchTerm.isEmpty) {
      return;
    } else {
      final filteredContacts = state.contacts
        .where((contact) =>
            contact.username.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
        emit(ContactState.loaded(state.contacts, filteredContacts));

    }
  }
}
