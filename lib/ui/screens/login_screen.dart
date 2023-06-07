import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_applica/ui/screens/bottom_navigation.dart';
import 'package:flutter_applica/ui/screens/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_applica/ui/screens/components/Component.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final bcolor = Color(0xff2470c7);
  bool loading = false;
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
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
                      "Carnet de voyage",
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
                              "Se connecter",
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
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: Text(
                                      "Mot de passe oublié?",
                                      style: TextStyle(color: Colors.black),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 55,
                            ),
                            RoundButton(
                                title: "Se connecter",
                                tapfun: () {
                                  FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailcon.text.toString(),
                                          password: passwordcon.text.toString())
                                      .then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BottomNavigation()));
                                  }).onError((error, stackTrace) {
                                    Fluttertoast.showToast(
                                        msg: "Email ou mot de passe invalide.",
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
                      "Vous n'avez pas de compte",
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
                                      RegisterScreen()));
                        },
                        child: Text("S'inscrire")),
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
