import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kbc/screen/loser.dart';
import 'package:kbc/screen/win.dart';
import 'package:kbc/services/QuestionModel.dart';
import 'package:kbc/services/QuizQueCreator.dart';
import 'package:kbc/services/firedb.dart';
import 'package:kbc/services/localdb.dart';
import 'package:kbc/widgets/lifeline_sidebar.dart';

class Question extends StatefulWidget {
  String quizID;
  int queMoney;
  Question({ required this.quizID , required this.queMoney});

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {

  QuestionModel questionModel = new QuestionModel();

  genQue() async{
    await QuizQueCreator.genQuizQue(widget.quizID, widget.queMoney).then((queData){

      setState(() {


        questionModel.question = queData["question"];
        questionModel.correctAnswer = queData["correctAnswer"];

        List options = [
          queData["opt1"],
          queData["opt2"],
          queData["opt3"],
          queData["opt4"],
        ];
        options.shuffle();

        questionModel.option1 = options[0];
        questionModel.option2 = options[1];
        questionModel.option3 = options[2];
        questionModel.option4 = options[3];

      });

    });
  }





  bool optALocked = false;
  bool optBLocked = false;
  bool optCLocked = false;
  bool optDLocked = false;
//CHANGE THE TIMER SECONDS ACCORDING TO MONEY WON
  int maxSeconds =  30;
  int seconds = 30;
  Timer? timer;

  QueTimer(){


    timer = Timer.periodic(Duration(seconds: 1), (_) {

      setState(() => seconds--);
      if(seconds==0){
        timer?.cancel();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Looser(wonMon: widget.queMoney == 5000 ? 0 :   widget.queMoney~/2, correctAns: questionModel.correctAnswer)));

      }
    });






  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genQue();
    QueTimer();

  }


  @override
  Widget build(BuildContext context) {


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
    await FireDB.updateMoney( widget.queMoney == 5000 ? 0 : widget.queMoney~/2);

    Navigator.pop(context , true);
    },
                child: Text("Okay!")
            ),
          ],
        )
    );


    return Container(
      decoration: BoxDecoration(image: DecorationImage(image:AssetImage("assets/img/background.png") )),
      child: WillPopScope(

        onWillPop: ()async{
          final exitQuiz = await showWarning(context: context , title: "DO YOU WANT TO EXIT QUIZ ?" , content : "You Will Get Rs.${ widget.queMoney == 5000 ? 0 : widget.queMoney/2} In Your Account.");
          return exitQuiz ?? false;

        },
        child: Scaffold(
          onDrawerChanged: (isOpened){
            timer?.cancel();
            isOpened ?
            timer?.cancel()


                : QueTimer();
          },
          backgroundColor: Colors.transparent,
          appBar: AppBar(title: Text("Rs.${widget.queMoney}" , style: TextStyle(fontSize: 25),), centerTitle: true,),
          drawer: Lifeline_Drawer(question: questionModel.question , opt1: questionModel.option1,
              opt2: questionModel.option2,
              opt3: questionModel.option3,
              opt4: questionModel.option4,
          correctAns: questionModel.correctAnswer,
          quizID: widget.quizID,

          currentQueMon: widget.queMoney,),
          floatingActionButton: ElevatedButton(child: Text("QUIT GAME" , style: TextStyle(fontSize: 27),),onPressed: (){
         showDialog(context: context, builder: (context)=>AlertDialog(
           title: Text("DO YOU WANT TO QUIT THE GAME"),
           content: Text("You will get Rs.${widget.queMoney == 5000 ? 0 : widget.queMoney/2} In Your Account."),
           actions: [
             ElevatedButton(onPressed: ()async{
               await FireDB.updateMoney(widget.queMoney == 5000 ? 0 : widget.queMoney~/2);
               timer?.cancel;
               Navigator.pop(context);
               Navigator.pop(context);
             }, child: Text("Quit")),
             ElevatedButton(onPressed: (){
               Navigator.pop(context);
             },
               child: Text("Cancel"),
             )
           ],
         ));

          },),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(

                height: 100,
                width: 100,
                child: Stack(
                  fit: StackFit.expand,
                  children: [

                    CircularProgressIndicator(strokeWidth: 12,backgroundColor: Colors.yellow,  value: seconds/maxSeconds,),
Center(child: Text(seconds.toString() , style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold,color: Colors.white),))
                  ],
                ),
              ),
              SizedBox(height: 20,),
           Container(
             padding: EdgeInsets.all(14),
             margin: EdgeInsets.all(17),
             decoration: BoxDecoration(color: Colors.white , borderRadius: BorderRadius.circular(20)),
             child : Text(questionModel.question , style: TextStyle(fontSize: 22), textAlign: TextAlign.center, )
           ),
SizedBox(height: 10,),
              InkWell(
                onTap : (){
                  print("DOUBLE TAP TO LOCK THE ANSWER");
                }
                ,
                onLongPress: (){
                  setState(() {
                    optALocked = true;
                  });

                  Future.delayed(Duration(seconds: 2) , () async{
                    if(questionModel.option1 == questionModel.correctAnswer){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Win(widget.queMoney ,widget.quizID  )));
                    }else{
                      await FireDB.updateMoney(widget.queMoney~/2);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Looser(wonMon: (widget.queMoney~/2), correctAns: questionModel.correctAnswer,)));
                    }
                  });

                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.symmetric(horizontal: 17,vertical: 5),
                    decoration: BoxDecoration(color: optALocked ?  Colors.yellow.withOpacity(0.4) : Colors.white.withOpacity(0.4) , borderRadius: BorderRadius.circular(34)),
                    child : Text("A. ${questionModel.option1}" , style: TextStyle(fontSize: 17 ,color:  Colors.white , fontWeight: FontWeight.bold), textAlign: TextAlign.center, )
                ),
              ),
              InkWell(
                onTap : (){
                  print("DOUBLE TAP TO LOCK THE ANSWER");
                }
                ,
                onLongPress: (){
                  setState(() {
                    optBLocked = true;
                  });

                  Future.delayed(Duration(seconds: 2) , () async{
                    if(questionModel.option2 == questionModel.correctAnswer){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Win(widget.queMoney ,widget.quizID  )));
                    }else{
                      await FireDB.updateMoney(widget.queMoney~/2);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Looser(wonMon: (widget.queMoney~/2), correctAns: questionModel.correctAnswer,)));
                    }
                  });

                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.symmetric(horizontal: 17,vertical: 5),
                    decoration: BoxDecoration(color: optBLocked ?  Colors.yellow.withOpacity(0.4) : Colors.white.withOpacity(0.4) , borderRadius: BorderRadius.circular(34)),
                    child : Text("B. ${questionModel.option2}" , style: TextStyle(fontSize: 17 ,color:  Colors.white , fontWeight: FontWeight.bold), textAlign: TextAlign.center, )
                ),
              ),
              InkWell(
                onTap : (){
                  print("DOUBLE TAP TO LOCK THE ANSWER");
                }
                ,
                onLongPress: (){
                  setState(() {
                    optCLocked = true;
                  });

                  Future.delayed(Duration(seconds: 2) , () async{
                    if(questionModel.option3 == questionModel.correctAnswer){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Win(widget.queMoney ,widget.quizID  )));
                    }else{
                      await FireDB.updateMoney(widget.queMoney~/2);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Looser(wonMon: (widget.queMoney~/2), correctAns: questionModel.correctAnswer,)));
                    }
                  });

                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.symmetric(horizontal: 17,vertical: 5),
                    decoration: BoxDecoration(color: optCLocked ?  Colors.yellow.withOpacity(0.4) : Colors.white.withOpacity(0.4) , borderRadius: BorderRadius.circular(34)),
                    child : Text("C. ${questionModel.option3}" , style: TextStyle(fontSize: 17 ,color:  Colors.white , fontWeight: FontWeight.bold), textAlign: TextAlign.center, )
                ),
              ),
              InkWell(
                onTap : (){
                  print("DOUBLE TAP TO LOCK THE ANSWER");
                }
                ,
                onLongPress: (){
                  setState(() {
                    optDLocked = true;
                  });

                  Future.delayed(Duration(seconds: 2) , () async{
                    if(questionModel.option4 == questionModel.correctAnswer){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Win(widget.queMoney ,widget.quizID  )));
                    }else{
                      await FireDB.updateMoney(widget.queMoney~/2);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Looser(wonMon: (widget.queMoney~/2), correctAns: questionModel.correctAnswer,)));
                    }
                  });

                },
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(14),
                    margin: EdgeInsets.symmetric(horizontal: 17,vertical: 5),
                    decoration: BoxDecoration(color: optDLocked ?  Colors.yellow.withOpacity(0.4) : Colors.white.withOpacity(0.4) , borderRadius: BorderRadius.circular(34)),
                    child : Text("D. ${questionModel.option4}" , style: TextStyle(fontSize: 17 ,color:  Colors.white , fontWeight: FontWeight.bold), textAlign: TextAlign.center, )
                ),
              ),
          ],),
        ),
      ),
    );
  }
}