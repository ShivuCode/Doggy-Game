import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doggy/home.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);
  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  int pos=0;
  int highScore=0;
  List<String> img=[
    "assets/dog.png",
    "assets/dog1.png",
    "assets/dog2.png"
  ];
  List<String> imgRight=[
    "assets/rightdog.png",
    "assets/dog1.png",
    "assets/dog2right.png"
  ];
  List<String> run=[
    "assets/dog.png",
    "assets/dog1.png",
    "assets/dog2run.png"
  ];
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        highScore = prefs.getInt("highScore") ?? 0;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white, minimumSize: const Size(250, 45),
      side: const BorderSide(color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (BuildContext context){
              return const AboutDialog(
                applicationName: "Doggy",
                applicationVersion: "1.2.3",
                applicationIcon: Icon(Icons.app_blocking_rounded,size: 35,),
                children: [
                  Text("Developed By Shivani Bind",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black54),),
                  SizedBox(height: 5),
                  Text("Its Basic Game. It is easy to play. In here One Dog who eat Bone We then give Second If Dog not eat his Health decrease and you Lose the game.",
                  style: TextStyle(fontSize: 16,color: Colors.black54)),
                ],
              );
            });
          }, splashRadius:30,icon: const Icon(CupertinoIcons.question_circle,color: Colors.black54,)),
          const SizedBox(width: 10)
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.blue.shade200,
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: const FractionalOffset(0.50, 0.05),
              child: Text(
                "High Score: $highScore",
                style: const TextStyle(
                    fontSize: 26,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(pos>=1)
              IconButton(onPressed: (){
                setState(() {
                  pos-=1;
                });
              },icon: const Icon(Icons.arrow_left,size: 20)),
              const SizedBox(width: 10),
              Image(image: AssetImage(img[pos]),width: 150,height: 200,),
              const SizedBox(width: 10),
              Visibility(visible:pos==2?false:true,child:
              IconButton(onPressed: (){
                setState(() {
                 pos+=1;
                });
              },icon: const Icon(Icons.arrow_right)))
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage(currentImg: [img[pos],imgRight[pos],run[pos]],)));
          },style: flatButtonStyle, child: const Text("Start")),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: (){
            SystemNavigator.pop();
          },style: flatButtonStyle, child: const Text("Exit"))
        ],),
      ),
    );
  }
}

