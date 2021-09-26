import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireDB{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createNewUser(String name , String email , String photoUrl , String uid) async{
    final User? current_user = _auth.currentUser;
    await FirebaseFirestore.instance.collection("users").doc(current_user!.uid).set(
      {
        "name" : name,
        "email" : email,
        "photoUrl" : photoUrl,
        "money" : "5000"
      }
    ).then((value)  {
      print("User Registered Successfully");
 
    });
  }
}