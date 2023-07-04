import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carnet_voyage/models/contact.dart';

class ContactCard extends StatelessWidget {

  final Contact contact;
  const ContactCard({required this.contact, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 60, // Hauteur de la liste horizontale
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context, '/contact-detail',
              arguments: contact
            ); // Navigation vers la deuxième page
          },
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Container(
                width: 60, // Largeur de chaque élément de la liste
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/4/40/Pedobear_Fancy.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, top: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.username),
                      Text(contact.description, style: TextStyle(fontSize: 10))
                    ]),
              )
            ],
          )),
    );
  }
}
