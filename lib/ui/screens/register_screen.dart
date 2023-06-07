import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carnet_voyage/ui/screens/bottom_navigation.dart';
import 'package:flutter_carnet_voyage/ui/screens/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_carnet_voyage/ui/screens/components/Component.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final bcolor = Color(0xff2470c7);
  bool loading = false;
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  final userNamecon = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  color: bcolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: Text(
                      "Showing",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.7,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "Inscription",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  TextFormField(
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return 'Enter Email';
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                      keyboardType: TextInputType.emailAddress,
                                      controller: emailcon,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                      )),
                                  TextFormField(
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'Enter Password';
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    controller: passwordcon,
                                    decoration: InputDecoration(
                                      hintText: "Mot de passe",
                                    ),
                                  ),
                                  TextFormField(
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return 'Enter Password';
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                    keyboardType: TextInputType.name,
                                    controller: userNamecon,
                                    decoration: InputDecoration(
                                      hintText: "Nom d'utilisateur",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 55,
                            ),
                            RoundButton(
                                title: "Inscription",
                                tapfun: () {
                                  FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailcon.text.toString(),
                                          password: passwordcon.text.toString())
                                      .then((value) {
                                        User? user = value.user;
                                        user?.updateDisplayName(userNamecon.toString());                                   
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigation()));
                                        return user;
                                        }).onError((error, stackTrace) {
                                          Fluttertoast.showToast(
                                            msg: "Une erreur s'est produite.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      });
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Déjà un compte",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LoginScreen())); //signUpScreen()));
                        },
                        child: Text("Se connecter")),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
