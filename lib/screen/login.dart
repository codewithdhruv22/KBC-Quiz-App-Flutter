import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:kbc/services/auth.dart';
class Login extends StatefulWidget {
  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        }),
        SizedBox(height: 10,),
        Text("By Continuing, You Are Agree With Our TnC" , style: TextStyle(color: Colors.white),)

      ],),),
    );
  }
}