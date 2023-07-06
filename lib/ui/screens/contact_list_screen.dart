import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/contact_cubit.dart';
import '../../blocs/contact_state.dart';
import '../../models/contact.dart';
import '../../models/data_state.dart';
import '../../repositories/contact_repository.dart';

class ContactList extends StatelessWidget {
  final ContactCubit contactCubit = ContactCubit(ContactRepository());

  @override
  Widget build(BuildContext context) {
    context.read<ContactCubit>().fetchContacts();
    return Scaffold(
    body: BlocBuilder<ContactCubit, ContactState>(
      builder: (context, state) {
        print(state.contacts.length);
        switch (state.dataState) {
      case DataState.loading:
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            child:
        const Center(child: CircularProgressIndicator()));
      case DataState.loaded:
        return BlocBuilder<ContactCubit, ContactState>(
        bloc: contactCubit,
        builder: (context, state) {
          return Column(
            children: [
              TextField(
                onChanged: (value) {
                  contactCubit.filterContacts(value);
                },
                decoration: InputDecoration(
                  hintText: 'Search contacts...',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = state.contacts[index];
                    return ListTile(
                      title: Text(contact.username),
                      subtitle: Text(contact.description),
                      // Affichez d'autres détails du contact selon vos besoins
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
      case DataState.error:
        return const Center(
          child: Text(
      'Une erreur est survenue, veuillez recommencer'),
        );
        }
      }
    ),
    
      
    );
  }
}
