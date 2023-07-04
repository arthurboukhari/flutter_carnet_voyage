import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carnet_voyage/repositories/user_repository.dart';
import 'package:flutter_carnet_voyage/ui/screens/bottom_navigation.dart';
import 'package:flutter_carnet_voyage/ui/screens/contact_detail_screen.dart';
import 'package:flutter_carnet_voyage/ui/screens/login_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'blocs/user_cubit.dart';

void main() async {

  if (kIsWeb) {
    await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyC8CXh5lxBfHH6-k3PuSl0DPD-PsWNd1DQ",
      appId: "1:83707367094:android:1f57908fef9ff90d08a017",
      messagingSenderId: "83707367094",
      projectId: "flutter-carnet-de-voyage",
    ),
  );
  }
  else {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  final UserRepository userRepository = UserRepository(FirebaseAuth.instance);
  final UserCubit userCubit = UserCubit(userRepository);
  await userCubit.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => userCubit,
        ),
      ],
      child: const MyApp(),
    ),
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
      home: BlocBuilder<UserCubit, bool>(
        builder: (context, isConnected) => isConnected ? const BottomNavigation() : const LoginScreen()
      ),
       routes: {
        '/contact-detail': (context) => ContactDetail(),
      },
    );
  }
}
