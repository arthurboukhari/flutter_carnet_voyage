import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carnet_voyage/blocs/user_cubit.dart';
import 'package:flutter_carnet_voyage/ui/screens/bottom_navigation.dart';
import 'package:flutter_carnet_voyage/ui/screens/components/authentication.dart';
import 'package:flutter_carnet_voyage/ui/screens/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_carnet_voyage/ui/screens/components/rounded_button.dart';

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
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthenticationAttributes authenticationAttributes =
        AuthenticationAttributes(
      emailController: emailcon,
      passwordController: passwordcon,
      formKey: formkey,
      formTitle: "Se connecter",
      formSubmitButton: RoundedButton(
          title: "Se connecter",
          tapfun: () async {
            if (formkey.currentState!.validate()) {
              try {
                await context.read<UserCubit>().login(
                    emailcon.text.toString(), passwordcon.text.toString());
              } catch (e) {
                Fluttertoast.showToast(
                    msg: "Email ou mot de passe invalide.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    webBgColor: "red",
                    fontSize: 16.0);
              }
            }
          }),
      footerText: "Vous n'avez pas de compte",
      footerTextButton: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
          child: Text("S'inscrire")),
      subFormExtraWidget: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text(
                "Mot de passe oublié?",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
    return Authentication(authenticationAttributes: authenticationAttributes);
  }
}
