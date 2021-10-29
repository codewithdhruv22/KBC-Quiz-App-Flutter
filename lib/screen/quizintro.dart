import 'package:flutter/material.dart';

class QuizIntro extends StatelessWidget {
  const QuizIntro({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton(child: Text("START QUIZ" , style: TextStyle(fontSize: 20),), onPressed: (){},),
      appBar: AppBar(title: Text("KBC Quiz App"),),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 40),
          child: 
        
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text("Quiz Name" , textAlign: TextAlign.center, style: TextStyle(fontSize: 30 , fontWeight: FontWeight.w500),)
          ],),),
      
      
         Image.network("https://images.unsplash.com/photo-1541873676-a18131494184?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=418&q=80" , fit: BoxFit.cover, height: 230 , width: MediaQuery.of(context).size.width,),
         Container(
           padding: EdgeInsets.all(18),
           child: 
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Row(
               children: [
                 Icon(Icons.topic_outlined),
                 SizedBox(width: 6,),
                 Text("Related To -" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)
               ],
             ),
             Text("Science , Space , Astronmy , Rocket , ISRO" , style: TextStyle(fontSize: 17),)
           ],),
         ) ,
         Container(
           padding: EdgeInsets.all(18),
           child: 
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

             Row(
               children: [
                 Icon(Icons.topic_outlined),
                 SizedBox(width: 6,),
                 Text("Duration -" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)
               ],
             ),
             Text("10 Minutes" ,textAlign: TextAlign.left, style: TextStyle(fontSize: 17),)
           ],),
         ) ,
         Container(
           padding: EdgeInsets.all(18),
           child: 
           Column(
              crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Row(
               children: [
                 Icon(Icons.topic_outlined),
                 SizedBox(width: 6,),
                 Text("About Quiz -" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),)
               ],
             ),
             Text("What is meant by Lorem Ipsum Image result for lorem ipsum Lorem Ipsum, sometimes referred to as 'lipsum', is the placeholder text used in design when creating content. It helps designers plan out where the content will sit, without needing to wait for the content to be written and approved. It originally comes from a Latin text, but to today's reader, it's seen as gibberish" , style: TextStyle(fontSize: 17),)
           ],),
         ) 
        ],)
        
        ,),
      ),
    );
  }
}
