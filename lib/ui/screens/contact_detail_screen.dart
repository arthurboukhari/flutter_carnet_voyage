import 'package:flutter/material.dart';
import '../../models/contact.dart';

class ContactDetail extends StatelessWidget {

  const ContactDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final contact = ModalRoute.of(context)!.settings.arguments as Contact?;
    if (contact == null) {
      Navigator.pop(context);      
    }
    return Stack(
        children: [
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                image:  NetworkImage('https://img.lemde.fr/2020/12/08/0/0/3360/2219/664/0/75/0/3136064_272175590-000-py9yj-1.jpg'), // Chemin de l'image de la bannière
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Positioned(
            
              top: 10.0,
              left: 10.0,
              child: Material(
                color: Color.fromARGB(0, 255, 255, 255),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ),
              ),
          ),
          Positioned(
            top: 115.0,
            left: 20.0,
            child: CircleAvatar(
              radius: 80.0,
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/4/40/Pedobear_Fancy.jpg'), // Chemin de l'image de profil
            ),
          ),
          Positioned(
            top: 300.0, 
            left: 20.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact!.username,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  contact.description,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ],
    );
  }
}
