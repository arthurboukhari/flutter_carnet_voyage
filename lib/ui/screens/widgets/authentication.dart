import 'package:flutter/material.dart';
import 'package:flutter_carnet_voyage/ui/screens/widgets/rounded_button.dart';

class Authentication extends StatelessWidget {
  AuthenticationAttributes authenticationAttributes;
  Authentication({required this.authenticationAttributes, super.key});

  @override
  Widget build(BuildContext context) {
    final bcolor = Color(0xff2470c7);
    bool loading = false;
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
                              authenticationAttributes.formTitle,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            Form(
                              key: authenticationAttributes.formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Renseigner une adresse mail';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.emailAddress,
                                      controller: authenticationAttributes.emailController,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                      )),
                                  TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Renseigner un mot de passe';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    controller: authenticationAttributes.passwordController,
                                    decoration: InputDecoration(
                                      hintText: "Mot de passe",
                                    ),
                                  ),
                                  if (authenticationAttributes.extraFormFields != null)
                                    ...authenticationAttributes.extraFormFields!.map((widget) => widget).toList(),                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            authenticationAttributes.subFormExtraWidget ?? SizedBox.shrink(),
                            SizedBox(
                              height: 55,
                            ),
                            authenticationAttributes.formSubmitButton
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
                      authenticationAttributes.footerText,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    authenticationAttributes.footerTextButton
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

class AuthenticationAttributes {
  GlobalKey<FormState> formKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  String formTitle;
  RoundedButton formSubmitButton;
  String footerText;
  TextButton footerTextButton;
  Widget? subFormExtraWidget;
  List<Widget>? extraFormFields;

  AuthenticationAttributes({required this.formKey, required this.emailController, required this.passwordController, required this.formTitle, required this.formSubmitButton, required this.footerText, required this.footerTextButton, this.subFormExtraWidget, this.extraFormFields});
}