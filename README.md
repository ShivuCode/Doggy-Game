# Doggy

Its Basic Game of Dog which is eat Bone under 10 seconds. When Dog not eat Bone it will destory automatically in 10 seconds and Dog Live Health also decrease by 1.
There se Three Type of Dogs are there and HighScore will be count when user make highscore then store new highScore will be displayed.




## How To make Doggy Game

Step 1: For make this you need to add this dependencies:

        shared_preferences: ^2.0.10


Step 2: Firstly Make Splash Screen which is display for 10 seconds

        class SplashScreen extends StatefulWidget {

        const SplashScreen({Key? key}) : super(key: key);

         @override
        State<SplashScreen> createState() => _SplashScreenState();
        }
        //todo:Splash Screen for game

        class _SplashScreenState extends State<SplashScreen> {
        bool startScreen=false;
         @override
         void initState() {

                Timer(const Duration(milliseconds: 3000), () {
                setState(() {
                Navigator.popAndPushNamed(context, 'start');
                });
        });
        super.initState();
        }
         @override
        Widget build(BuildContext context) {
        return Scaffold(
        backgroundColor: Colors.blue.shade200,
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
                const Text.rich(
                        TextSpan(text: """“Only he who can see the\n """,style: TextStyle(
                fontSize: 26,color: Colors.white,fontWeight: FontWeight.bold
              ),
              children: [
                TextSpan(text: """invisible can do the impossible.”""",style:TextStyle(
                  fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold
                ))
              ])),
                Image.asset("assets/dog.png",width: 200,height: 400,),
                const SizedBox(height: 15),
                ],
                ),
         ),
         );
        }}

   
Step 3: Now, We Create Start Screen of Game.

        import 'package:flutter/cupertino.dart';
        import 'package:flutter/material.dart';
        import 'package:Doggy/Home.dart';
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
                }, splashRadius:30,icon: Icon(CupertinoIcons.question_circle,color: Colors.black54,)),
                SizedBox(width: 10)
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
                        children: 
                            [
                                if(pos>=1)
                                IconButton(onPressed: (){
                                        setState(() {
                                        pos-=1;
                                        });
                                },icon: const Icon(Icons.arrow_left,size: 20)),

                                const SizedBox(width: 10),

                                Image(image: AssetImage(img[pos]),width: 150,height: 200,),
                                
                                const SizedBox(width: 10),
                                
                                Visibility(visible:pos==2?false:true,
                                child: IconButton(onPressed: (){
                                        setState(() {
                                        pos+=1;
                                        });
                                },icon: const Icon(Icons.arrow_right)))
                            ],
                        ),
                        const SizedBox(height: 20),

                        ElevatedButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_)=>Home(currentImg: [img[pos],imgRight[pos],run[pos]],)));
                        }, child:Text("Start"),style: flatButtonStyle),

                        const SizedBox(height: 10),

                        ElevatedButton(onPressed: (){
                                SystemNavigator.pop();
                        }, child: Text("Exit"),style: flatButtonStyle)
                    ],
                  ),
                ),
              );
           }
        }

Step 4: Now, We create Play Screen of Game

        import 'dart:async';
        import 'dart:math';
        import 'package:flutter/cupertino.dart';
        import 'package:flutter/material.dart';
        import 'package:flutter/services.dart';
        import 'package:Doggy/Start.dart';
        import 'package:shared_preferences/shared_preferences.dart';

        class Home extends StatefulWidget {
        Home({Key? key,required this.currentImg}) : super(key: key);
        List<String> currentImg;
        @override
        State<Home> createState() => _HomeState();
        }

        class _HomeState extends State<Home> {
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
                        ),
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
                        alignment: FractionalOffset(0,1),
                        child: TextButton(onPressed: (){
                        loseGame();
                        }, child: Text("Exit",style: TextStyle(color: Colors.black54),)),
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




   
