import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireDB{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createNewUser(String name , String email , String photoUrl , String uid) async{
    final User? current_user = _auth.currentUser;
  if(await getUser()){
    print("USER ALREADY EXISTS");
  }else{
    await FirebaseFirestore.instance.collection("users").doc(current_user!.uid).set(
      {
        "name" : name,
        "email" : email,
        "photoUrl" : photoUrl,
        "money" : "55555"
      }
    ).then((value)  {
      print("User Registered Successfully");
 
    });

  }

  }


  Future<bool> getUser() async{
    final User? current_user = _auth.currentUser;
    String user = "";

    await FirebaseFirestore.instance.collection("users").doc("sjfsjfksjmn").get().then((value){
      user = value.data().toString();
      print(user);
    });
    if(user.toString() == "null"){
      return false;
    }else{
      return true;
    }
  }






}