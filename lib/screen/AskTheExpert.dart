import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AskTheExpert extends StatefulWidget {
  String question;
  String yTURL;
  AskTheExpert({
    required this.question,
    required this.yTURL
});

  @override
  _AskTheExpertState createState() => _AskTheExpertState();
}

class _AskTheExpertState extends State<AskTheExpert> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 20) , (){
      Navigator.pop(context);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body : Center(
        child:  Container(
          margin: EdgeInsets.symmetric(vertical: 200 , horizontal: 30),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(30)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("ASK THE EXPERT LIFELINE" , style: TextStyle(fontSize: 26 , fontWeight: FontWeight.bold , color: Colors.white), textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Text("QUESTION - ${widget.question} " ,  style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: Colors.white), textAlign: TextAlign.center,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                child: YoutubePlayer(

                  controller: YoutubePlayerController(
                    initialVideoId: widget.yTURL, //Add videoID.

                    flags: YoutubePlayerFlags(
                      hideControls: true,
                      controlsVisibleAtStart: false,
                      autoPlay: true,
                      mute: false,

                    ),
                  ),
                  showVideoProgressIndicator: true,

                ),

              ),
              Text("You Will Be Redirected To Quiz Screen In 20 Seconds." ,  style: TextStyle(fontSize: 16 , fontWeight: FontWeight.w400 , color: Colors.white), textAlign: TextAlign.center,),
            ],
          ),
        ),
      )
    );
  }
}
