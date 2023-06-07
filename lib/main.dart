import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_carnet_voyage/ui/screens/bottom_navigation.dart';
import 'package:flutter_carnet_voyage/ui/screens/login_screen.dart';
// import 'firebase_options.dart';

main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC8CXh5lxBfHH6-k3PuSl0DPD-PsWNd1DQ",
      appId: "1:83707367094:android:1f57908fef9ff90d08a017",
      messagingSenderId: "83707367094",
      projectId: "flutter-carnet-de-voyage"
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
