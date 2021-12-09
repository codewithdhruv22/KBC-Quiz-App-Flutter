import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:kbc/screen/question.dart';
import 'package:kbc/services/firedb.dart';

class Win extends StatefulWidget {
  int queMoney;
  String QuizID;
  Win(this.queMoney , this.QuizID);

  @override
  _WinState createState() => _WinState();
}
//MAKE A GRAND WINNING SCREEN
class _WinState extends State<Win> {

  late ConfettiController confettiController;





  playWinSound() async {

    final player = AudioCache();
    player.play("audio_effects/CORRECT.mp3");
  }



  @override
  void initState() {

    super.initState();
    setState(() {
      initController();
    });
    playWinSound();
    confettiController.play();
  }





  Future<bool?> showWarning({ required  BuildContext context , required String title , required String content}) async => showDialog(
      context: context,
      builder: (context)=>AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          ElevatedButton(
              onPressed: () => Navigator.pop(context , false),
              child: Text("No!")
          ),
          ElevatedButton(

              onPressed: () async{
                await FireDB.updateMoney( widget.queMoney);
  Navigator.pop(context , true)    ;
  } ,
              child: Text("Okay!")
          ),
        ],
      )
  );



  void initController() {
    confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final exitQuiz = await showWarning(context: context , title: "DO YOU WANT TO EXIT QUIZ ?" , content : "You will get Rs.${widget.queMoney} In Your Account.");
        return exitQuiz ?? false;

      },
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/img/win.png" ) , fit: BoxFit.cover)),
        child: Scaffold(
          floatingActionButton: ElevatedButton(child: Text("Share With Friends"), onPressed: (){},),
          backgroundColor : Colors.transparent,
          body : Stack(
            children: [
              Container(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
Text("CONGRATULATIONS!" , style: TextStyle(fontSize: 30, fontWeight : FontWeight.bold,)),
Text("YOUR ANSWER IS CORRECT" , style: TextStyle(fontSize: 17 , fontWeight : FontWeight.w500,)),
SizedBox(height: 15,),
Text("You Won",style: TextStyle(fontSize: 15 , fontWeight : FontWeight.w400,)),
Text("Rs.${widget.queMoney}",style: TextStyle(fontSize: 35 , fontWeight : FontWeight.w700,)),
SizedBox(height: 25,),
Container(
  padding: EdgeInsets.all(20),
  child: Image.asset("assets/img/cheque.jpg")) ,
  ElevatedButton(child: Text("Next Question"), onPressed: (){

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Question(quizID: widget.QuizID, queMoney: (widget.queMoney)*2 )));
  },)
                  ]
                )
              ),
buildConfettiWidget(confettiController, pi / 2),

            ],
          )
        ),
      ),
    );
  }


Align buildConfettiWidget(controller, double blastDirection){
  return Align(alignment: Alignment.topCenter,
  child: ConfettiWidget(
    maximumSize: Size(40,30),
    shouldLoop: false,
    confettiController: controller,
    blastDirection: blastDirection,
    blastDirectionality: BlastDirectionality.explosive,
    maxBlastForce: 20,
    minBlastForce: 8,
    emissionFrequency: 0.2,
    numberOfParticles: 8,
    gravity: 0.01,
  ),
  );
}


}
