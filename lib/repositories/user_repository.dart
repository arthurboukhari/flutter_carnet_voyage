import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  UserRepository(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  Future<bool> init() async {
    return firebaseAuth.currentUser != null;
  }

  Future<void> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signup(String email, String password, String username) async {
      await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
          User? user = value.user;
          await user?.updateDisplayName(username);
        });
  }


  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}