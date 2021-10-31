import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:kbc/services/localdb.dart';
import 'package:kbc/widgets/sidenavbar.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {




    String name = "User Name";
    String money = "--";
    String lead = "---";
    String proUrl = "---";

  getUserDet() async{
    await LocalDB.getName().then((value){
      setState((){
        name = value.toString();
      });
    });


    await LocalDB.getMoney().then((value){
      setState((){
        money = value.toString();
      });
    });


    await LocalDB.getRank().then((value){
      setState((){
        lead = value.toString();
      });
    });

       await LocalDB.getUrl().then((value){
      setState((){
        proUrl = value.toString();
      });
    });
  }


@override
  void initState() {
    super.initState();
    getUserDet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('KBC - Quiz Game'),),
      drawer: SideNav(name , money , lead , proUrl),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              CarouselSlider(
                items: 
                [
          Container(
                  decoration:  BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(image : NetworkImage("https://images.unsplash.com/photo-1632931612792-fbaacfd952f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1332&q=80" ,) , fit: BoxFit.cover)),
                ),
                ],
                
                options: CarouselOptions(
                  height: 180,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16/9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(
                    milliseconds: 800
                  ),
                  viewportFraction: 0.8
                )),
      
      
      
                Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
      Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Stack(
          children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            
              height: 150,
              child: Image.network("https://images.unsplash.com/photo-1632931612792-fbaacfd952f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1332&q=80" ,fit: BoxFit.cover,  ),),
        ),
          
        
          ],
        )),
      SizedBox(width: 10),
        Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Stack(
          children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            
            height: 150,
            child: Image.network("https://images.unsplash.com/photo-1632931612792-fbaacfd952f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1332&q=80",fit: BoxFit.cover),),
        ),
        Positioned(
          top: 3,
          bottom: 3,
          left: 3,
          right: 3,
          child: Container(color: Colors.black38,)),
          Padding(
            padding: EdgeInsets.all(35),
            child: Align(
              alignment: Alignment.center,
              child: Column(
              
                children: [
                      Icon(Icons.lock , size:30 , color: Colors.white,),
                Text("Rs.53,000" , style: TextStyle(color: Colors.white , fontSize: 14 , fontWeight: FontWeight.bold)),
                Text("DSA QUiz UPSC THIS IS" , style: TextStyle(color: Colors.white , fontSize: 13 , fontWeight: FontWeight.bold , ), textAlign:  TextAlign.center,overflow: TextOverflow.ellipsis,)
                ],
               
            
              ),
            ),
          )
          ],
        ))
      
                    ],
                  ),
                )
      ,
         Container(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: [
      Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Stack(
          children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            
              height: 150,
              child: Image.network("https://images.unsplash.com/photo-1632931612792-fbaacfd952f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1332&q=80" ,fit: BoxFit.cover,  ),),
        ),
          
        
          ],
        )),
      SizedBox(width: 10),
        Flexible(
        flex: 1,
        fit: FlexFit.tight,
        child: Stack(
          children: [
        Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            
            height: 150,
            child: Image.network("https://images.unsplash.com/photo-1632931612792-fbaacfd952f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1332&q=80",fit: BoxFit.cover),),
        ),
        Positioned(
          top: 3,
          bottom: 3,
          left: 3,
          right: 3,
          child: Container(color: Colors.black38,)),
          Padding(
            padding: EdgeInsets.all(35),
            child: Align(
              alignment: Alignment.center,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                      Icon(Icons.lock , size:30 , color: Colors.white,),
                Text("Rs.53,000" , style: TextStyle(color: Colors.white , fontSize: 14 , fontWeight: FontWeight.bold) , textAlign:  TextAlign.center,),
                Text("DSA QUiz UPSC THIS IS" , style: TextStyle(color: Colors.white , fontSize: 13 , fontWeight: FontWeight.bold , ), textAlign:  TextAlign.center,overflow: TextOverflow.ellipsis,)
                ],
               
            
              ),
            ),
          )
          ],
        ))
      
                    ],
                  ),
                ),
      
      
      
      
       Container(
  
         padding: EdgeInsets.symmetric(horizontal: 12),
         child: Stack(
        children: [
          Card(
            elevation: 8,
            
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Container(
              width: MediaQuery.of(context).size.width,
            
              height: 150,
              child: Image.network("https://images.unsplash.com/photo-1632931612792-fbaacfd952f6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1332&q=80",fit: BoxFit.cover),),
          ),
          Positioned(
            top: 3,
            bottom: 3,
            left: 3,
            right: 3,
            child: Container(color: Colors.black38,)),
            Padding(
              padding: EdgeInsets.all(35),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                
                  children: [
                        Icon(Icons.lock , size:30 , color: Colors.white,),
                        SizedBox(height: 2),
                  Text("Rs.53,000" , style: TextStyle(color: Colors.white , fontSize: 14 , fontWeight: FontWeight.bold)),
                  Text("Flutter Quiz" , style: TextStyle(color: Colors.white , fontSize: 13 , fontWeight: FontWeight.bold))
                  ],
                 
              
                ),
              ),
            )
        ],
          ),
       )
      
      
      
      
      
      
      
      
          ],),
        ),
      )
    );
  }
}