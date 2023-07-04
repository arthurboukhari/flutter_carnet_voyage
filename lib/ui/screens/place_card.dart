import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';


class PlaceCard extends StatefulWidget {
  const PlaceCard({super.key});

  @override
  State<PlaceCard> createState() => _PlaceCardState();
}

class _PlaceCardState extends State<PlaceCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      color: Color.fromARGB(255, 245, 243, 243),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context, '/place-detail'
          ); // Navigation vers la deuxième page
        },
        child: Column(
          children: [
            Image(image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg')),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              decoration: BoxDecoration(
                color: Colors.grey[100]
              ),
              child: Column(
                children: [
                  Text("Titre"),
                  Text("categories")
              ])
            )
          ]
        ),
      ),
    );
  }
}