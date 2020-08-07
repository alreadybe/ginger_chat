import 'package:firebase_auth/firebase_auth.dart';
import 'package:read_head_chat/models/user.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future signIn(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user != null ? User(id: user.uid) : null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUp(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user != null ? User(id: user.uid, email: user.email) : null;
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
