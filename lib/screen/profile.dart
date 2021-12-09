import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kbc/services/localdb.dart';

class Profile extends StatefulWidget {
  String name;
  String proUrl;
  String rank;
  String level;
  String money;
  Profile({
required this.name,
required this.proUrl,
required this.level,
required this.rank,
required this.money,
  });

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late  List<QueryDocumentSnapshot<Map<String, dynamic>>> LeadersList;
  getLeaders() async{

    await FirebaseFirestore.instance.collection("users").orderBy("money").get().then((value){

        setState(() {
          LeadersList = value.docs.reversed.toList();
          widget.rank =  (LeadersList.indexWhere((element) => element.data()["name"] == widget.name) + 1).toString();
        });


    });

    await LocalDB.saveRank(widget.rank);


    }


  String k_m_b_generator(num) {
    if (num > 999 && num < 99999) {
      return "${(num / 1000).toStringAsFixed(1)} K";
    } else if (num > 99999 && num < 999999) {
      return "${(num / 1000).toStringAsFixed(0)} K";
    } else if (num > 999999 && num < 999999999) {
      return "${(num / 1000000).toStringAsFixed(1)} M";
    } else if (num > 999999999) {
      return "${(num / 1000000000).toStringAsFixed(1)} B";
    } else {
      return num.toString();
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLeaders();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.share)),
          IconButton(onPressed: (){}, icon: Icon(Icons.person_add)),
        ],
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 29),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(

        child: Column(

          children: [

            Container(
              padding: EdgeInsets.only(top : 40),
              height: 370,
              decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20))),
              child: Column(

                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            widget.proUrl),
                        radius: 50,
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(shape: BoxShape.circle ,color: Colors.white),child: Icon(Icons.edit,color: Colors.purpleAccent,),),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.name}\nRs.${k_m_b_generator(int.parse(widget.money))}",
                    style: TextStyle(
                        fontSize: 22,

                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [

                      Column(
                        children: [
                          Text("#${widget.rank}",
                              style: TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white.withOpacity(0.9))),
                          Text("Rank",
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Leaderboard",
              style: TextStyle(fontSize: 20),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.all(20),
                  child: SizedBox(
                    height: 300,
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      LeadersList[index].data()["photoUrl"]),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text( LeadersList[index].data()["name"].toString().length >=12 ?  "${(LeadersList[index].data()["name"]).toString().substring(0,12)}..." : (LeadersList[index].data()["name"]).toString()  )
                              ],
                            ),
                            leading: Text("#${index + 1}" ,style: TextStyle(fontWeight: FontWeight.bold),),
                            trailing: Text(
                                "Rs.${ k_m_b_generator(int.parse(LeadersList[index].data()["money"].toString()))}",style: TextStyle(fontWeight: FontWeight.bold)),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(thickness: 1,color: Colors.purple,indent: 10,endIndent: 10,),
                        itemCount: LeadersList.length),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
