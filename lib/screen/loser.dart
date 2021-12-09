import 'package:flutter/material.dart';

class Looser extends StatelessWidget {
  int wonMon;
  String correctAns;

  Looser({required this.wonMon, required this.correctAns});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/loose.png"), fit: BoxFit.cover)),
      child: Scaffold(
          floatingActionButton: ElevatedButton(
            child: Text("Retry"),
            onPressed: () {},
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Oh Sorry!",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                  Text("YOUR ANSWER IS INCORRECT",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                  Text("CORRECT ANSWER IS ${correctAns}",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Text("You Won",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                  Text("Rs.${wonMon == 2500 ? 0 : wonMon}",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Icon(Icons.error_outline, size: 100, color: Colors.white),
                  ElevatedButton(
                    child: Text("Go To Rewards"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ]),
          )),
    );
  }
}
