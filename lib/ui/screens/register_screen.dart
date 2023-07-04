import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_carnet_voyage/blocs/user_cubit.dart';
import 'package:flutter_carnet_voyage/ui/screens/components/authentication.dart';
import 'package:flutter_carnet_voyage/ui/screens/login_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_carnet_voyage/ui/screens/components/rounded_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailcon = TextEditingController();
  final passwordcon = TextEditingController();
  final userNamecon = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AuthenticationAttributes authenticationAttributes =
        AuthenticationAttributes(
            emailController: emailcon,
            passwordController: passwordcon,
            formKey: formkey,
            formTitle: "Inscription",
            formSubmitButton: RoundedButton(
                title: "Inscription",
                tapfun: () async {
                  if (formkey.currentState!.validate()) {
                    try {
                      await context.read<UserCubit>().signup(
                          emailcon.text.toString(),
                          passwordcon.text.toString(),
                          userNamecon.text.toString());
                    } catch (e) {
                      Fluttertoast.showToast(
                          msg: "Une erreur s'est produite.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          webBgColor: "red",
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  }
                }),
            footerText: "Déjà un compte",
            footerTextButton: TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text("Se connecter")),
            extraFormFields: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Renseigner un nom d'utilisateur";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.name,
            controller: userNamecon,
            decoration: InputDecoration(
              hintText: "Nom d'utilisateur",
            ),
          ),
        ]);
    return Authentication(authenticationAttributes: authenticationAttributes);
  }
}
