import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  HomePage({Key? key,required this.currentImg}) : super(key: key);
  List<String> currentImg;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String img="";
  double xPlayer = 0.5;
  double yPlayer = 1.0;
  double xTarget = 0;
  double yTarget = 0;

  bool boneDestroyed = false;

  int live=3;
  int score = 0;
  int _remainingTime = 0;
  int highScore=0;

  Timer? _timer;

  start() {
    Random randomX = Random();
    Random randomY = Random();
    _restartTimer();
    setState(() {
      xTarget = randomX.nextDouble();
      yTarget = randomY.nextDouble();
      boneDestroyed = false;
    });
    if(live==0){
      loseGame();
      _timer!.cancel();
    }
  }

  void _restartTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    setState(() {
      _remainingTime = 10;
    });
    _startTimer();
  }

  void _startTimer() {
    const oneSec = Duration(milliseconds: 1000);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
            setState(() {
              if (_remainingTime > 0) {
                _remainingTime--;
              } else {
                boneDestroyed=true;
                if(live==0){
                  loseGame();
                  _timer!.cancel();
                }else {
                  live-=1;
                  start();
                }
              }
            });
      },
    );
  }

  loseGame()async{
    await showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: const Text("End Game",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
        titleTextStyle:const TextStyle(fontWeight:FontWeight.bold,fontSize: 26),
        content: Text("Your Score is: $score"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text("OK"))
        ],
      );
    });
    if (score > highScore) {
      setState(() {
        highScore = score;
      });
      // save the new high score to local storage
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt("highScore", highScore);
    }
    // ignore: use_build_context_synchronously
    Navigator.popAndPushNamed(context, 'start');
  }

  destroy() {
    setState(() {
      boneDestroyed = true;
      // boomShow=false;
      score++;
      start();
    });
  }

  @override
  void initState() {
    start();
    img=widget.currentImg[0];
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    double distance =
    sqrt(pow(xPlayer - xTarget, 3) + pow(yPlayer - yTarget, 3));
    if (distance < 0.05) {
      destroy();
    }
    return RawKeyboardListener(
      focusNode: FocusNode(),
      onKey: (RawKeyEvent event) {
        if (event is RawKeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            setState(() {
              yPlayer -= 0.05;
            });
          } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            setState(() {
              yPlayer += 0.05;
            });
          } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            setState(() {
              xPlayer -= 0.05;
            });
          } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            setState(() {
              xPlayer += 0.05;
            });
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.blue.shade200,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Container(
                alignment:const  FractionalOffset(0.02,0.05),
                child: Row(
                  children: [
                    Icon(live>=1?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: Colors.red,size: 30),
                    Icon(live>=2?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: Colors.red,size: 30),
                    Icon(live>=3?CupertinoIcons.heart_fill:CupertinoIcons.heart,color: Colors.red,size: 30),
                    const SizedBox(width: 20),
                    Text( _remainingTime>=10?"00:$_remainingTime":"00:0$_remainingTime")
                  ],
                ),
              ),
              Container(
                alignment: const FractionalOffset(0.90, 0.05),
                child: Text(
                  "Score : $score",
                  style: const TextStyle(fontSize: 26,
                      color: Colors.black54,
                      fontWeight: FontWeight.bold),
                )
              ),
              if (!boneDestroyed)
                Container(
                  alignment: FractionalOffset(xTarget, yTarget),
                  child: const Image(
                      image: AssetImage("assets/bone.png"),
                      height: 150,
                      width: 50),
                ),
              Container(
                alignment: FractionalOffset(xPlayer, yPlayer),
                child: Image(
                    image: AssetImage(img), height: 200, width: 80),
              ),
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            child: Container(
              color: Colors.blue.shade200,
              height: 160,
              padding: const EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
               children:[
                 Container(
                   alignment: const FractionalOffset(0,1),
                   child: TextButton(onPressed: (){
                     loseGame();
                   }, child: const Text("Exit",style: TextStyle(color: Colors.black54),)),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.end,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(
                       height: 100,
                       width: 60,
                       child: IconButton(onPressed: (){
                         setState(() {
                           xPlayer-=0.10;
                         });
                       }, icon: const Icon(CupertinoIcons.left_chevron)),
                     ),
                     Column(
                       children: [
                         Container(
                           alignment: Alignment.center,
                           width: 60,
                           height: 50,
                           child: IconButton(onPressed: (){
                             setState(() {
                               yPlayer-=0.10;
                             });
                           }, icon: const Icon(CupertinoIcons.chevron_up)),
                         ),
                         const SizedBox(height: 50),
                         Container(
                           alignment: Alignment.center,
                           width: 60,height: 50,
                           child: IconButton(onPressed: (){
                             setState(() {
                               yPlayer+=0.10;
                             });
                           }, icon: const Icon(CupertinoIcons.chevron_down)),
                         ),

                       ],
                     ),
                     SizedBox(
                       width: 60,height: 100,
                       child: IconButton(onPressed: (){
                         setState(() {
                           xPlayer+=0.10;
                         });
                       }, icon: const Icon(CupertinoIcons.right_chevron)),
                     ),
                   ],
                 )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}