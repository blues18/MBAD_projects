import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facilitiesbookingapp/models/User_auth_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication_services{
  Future<UserCredential> register(email,password,){
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

  Future<void> registerUser(email, userName, userPhoneNumber, image_url){
    return FirebaseFirestore.instance
        .collection('UserData')
        .doc(email)
        .set({'UserName': userName, 'UserPhoneNumber': userPhoneNumber, 'Url_Image': image_url});
  }
 addImage(email, image_Url){
    return FirebaseFirestore.instance
        .collection('UserData')
        .doc(email)
        .update({'Url_Image': image_Url});
  }

 User? getcurrentUser(){
    print(FirebaseAuth.instance.currentUser);
    return FirebaseAuth.instance.currentUser;
 }

  Stream<userModel>getUserAuthenticationData(){
    return FirebaseFirestore.instance
        .collection('UserData')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .map<userModel>((doc) => userModel.fromMap(doc.data()));
  }

  UpdateUser(email, userName, UserPhoneNumber){
    return FirebaseFirestore.instance
        .collection('UserData')
        .doc(email)
        .update({'UserName': userName,'UserPhoneNumber':UserPhoneNumber,});
  }
}