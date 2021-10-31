import 'package:flutter/material.dart';
import 'package:kbc/screen/home.dart';
import 'package:kbc/screen/login.dart';
import 'package:kbc/services/auth.dart';
import 'package:kbc/services/localdb.dart';

class SideNav extends StatelessWidget {
  String name;
  String money;
  String rank;
  String proUrl;
  SideNav( @required this.name ,@required this.money ,@required this.rank , @required this.proUrl);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color.fromRGBO(128, 0, 128, 1),
        child: ListView(
          // padding:  EdgeInsets.symmetric(horizontal: 20),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 20),
              child: Row(children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(proUrl),),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name , style: TextStyle(color: Colors.white , fontSize: 20 , fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Text("Rs.$money" , style: TextStyle(color: Colors.white , fontSize: 15),)
                ],
              )  
              ],),

            ),
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Text("Leaderboard - $rank th Rank" , style: TextStyle(color: Colors.white ,fontSize: 19,fontWeight: FontWeight.bold,))
            ),
            SizedBox(height: 48,),
            listItem(
              context: context,
              path:  MaterialPageRoute(builder: (BuildContext context) => Home()),
              label : "DAILY QUIZ",
              icon : Icons.quiz
            ),
              listItem(
                context: context,
              path:  MaterialPageRoute(builder: (BuildContext context) => Home()),
              label : "Leaderboard",
              icon : Icons.leaderboard
            ),
              listItem(
                context: context,
              path:  MaterialPageRoute(builder: (BuildContext context) => Home()),
              label : "How To Use",
              icon : Icons.question_answer
            ),
              listItem(
                context: context,
              path:  MaterialPageRoute(builder: (BuildContext context) => Home()),
              label : "About Us",
              icon : Icons.face
            ),
              listItem(
                context: context,
              path:  MaterialPageRoute(builder: (BuildContext context) => Login()),
              label : "Logout",
              icon : Icons.logout
            )
          ],
        ),
        ),
    );
  }

  Widget listItem({
    required String label,
    required IconData icon,
    required BuildContext context,
    required MaterialPageRoute path
  }){
    final color = Colors.white;
    final hovercolor = Colors.white60;

    return ListTile(
      leading: Icon(icon , color: color,),
      hoverColor: hovercolor,
      title: Text(label , style: TextStyle(color: color)),
      onTap: () async {
        await signOut();
Navigator.pushReplacement(context, path);
      },
    );
  }
}