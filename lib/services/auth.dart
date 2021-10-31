import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firedb.dart';
import 'localdb.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User?> signWithGoogle() async{

  // try{


  final GoogleSignInAccount? googlesignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = await googlesignInAccount!.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken , accessToken: googleSignInAuthentication.accessToken);

  final usercredential = await _auth.signInWithCredential(credential);

  final User? user = usercredential.user;

  assert(!user!.isAnonymous);
  // ignore: unnecessary_null_comparison
  assert(await user!.getIdToken() != null);

  final User? currentUser = _auth.currentUser;
  assert(currentUser!.uid == user!.uid);
await FireDB().createNewUser(user!.displayName.toString(), user.email.toString(), user.photoURL.toString() , user.uid.toString());
await LocalDB.saveUserID(user.uid);
await LocalDB.saveName(user.displayName.toString());
await LocalDB.saveUrl(user.photoURL.toString());

  print(user);
  // }catch(e){
  //   print("ERROR OCCURED IN SIGN IN");
  //   print(e);
  // }
  
}

Future<String> signOut() async
{
  await googleSignIn.signOut();
  await _auth.signOut();
  await LocalDB.saveUserID("null");
  return "SUCCESS";
}