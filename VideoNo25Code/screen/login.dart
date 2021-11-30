import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kbc/screen/home.dart';
import 'package:kbc/services/InternetCon.dart';
import 'package:kbc/services/auth.dart';
import 'package:kbc/services/firedb.dart';
import 'package:kbc/services/localdb.dart';
import 'package:overlay_support/overlay_support.dart';
class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}



class _LoginState extends State<Login> {

  @override
  void initState() {
    super.initState();

InternetConnectionChecker().onStatusChange.listen((status) {
  final connected = status == InternetConnectionStatus.connected;
 showSimpleNotification(Text(connected ? "CONNECTED TO INTERNET" : "NO INTERNET") ,background: Colors.green);
 });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Image.asset("assets/img/kbc.png"),
        SizedBox(height: 35,),
        Text("Welcome \n To KBC Quiz App" , style: TextStyle(fontSize: 25 ,color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
        SizedBox(height: 12,),
        SignInButton(Buttons.GoogleDark, onPressed: () async{
          await signWithGoogle();

       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Home()));
        }),
        SizedBox(height: 10,),
        Text("By Continuing, You Are Agree With Our TnC" , style: TextStyle(color: Colors.white),)

      ],),),
    );
  }
}