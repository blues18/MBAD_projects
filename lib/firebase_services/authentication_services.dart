import 'package:firebase_auth/firebase_auth.dart';

class Authentication_services{
  Future<UserCredential> register(email,password){
    return FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }
  Future<UserCredential> login(email,password){
    return FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> forgotPassword(email){
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  Stream<User?> getAuthenticationUser() {
    return FirebaseAuth.instance.authStateChanges();
  }
  loginOut(){
    return FirebaseAuth.instance.signOut();
  }
}