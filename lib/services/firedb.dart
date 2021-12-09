import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kbc/services/localdb.dart';

class FireDB {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  createNewUser(String name, String email, String photoUrl, String uid) async {
    final User? current_user = _auth.currentUser;
    if (await getUser()) {
      print("USER ALREADY EXISTS");
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(current_user!.uid)
          .set({
        "name": name,
        "email": email,
        "photoUrl": photoUrl,
        "money": 0,
        "rank" :  "NA",
        "level" : "0"
      }).then((value) async {
        await LocalDB.saveMoney("0");
        await LocalDB.saveRank("NA");
        await LocalDB.saveLevel("0");
        print("User Registered Successfully");
      });
    }
  }
  
  static updateMoney(int amount) async{
    if(amount != 2500){
      final FirebaseAuth _myauth = FirebaseAuth.instance;

      await FirebaseFirestore.instance.collection("users").doc(_myauth.currentUser!.uid).get().then((value) async{
        await LocalDB.saveMoney((value.data()!["money"] + amount).toString());
        await FirebaseFirestore.instance.collection("users").doc(_myauth.currentUser!.uid).update(
            {"money" : value.data()!["money"] + amount})  ;
      });
    }


  }



  Future<bool> getUser() async {
    final User? current_user = _auth.currentUser;
    String user = "";

    await FirebaseFirestore.instance
        .collection("users")
        .doc(current_user!.uid)
        .get()
        .then((value) async {
      user = value.data().toString();
      print(user);
      await LocalDB.saveMoney("999989");
      await LocalDB.saveRank("444");
      await LocalDB.saveLevel("45");
    });
    if (user.toString() == "null") {
      return false;
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(current_user!.uid)
          .get()
          .then((value) async {
        user = value.data().toString();
        print(user);
        await LocalDB.saveMoney(value["money"].toString());
        await LocalDB.saveRank(value["rank"]);
        await LocalDB.saveLevel(value["level"]);
      });
      return true;
    }
  }
}
