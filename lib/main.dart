import 'dart:async';
import 'package:flutter/material.dart';
import 'Start.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute: 'splash',
     debugShowCheckedModeBanner: false,
     routes: {
       'start': (_)=>const Start(),
       'splash':(_)=>const SplashScreen(),
       // ignore: equal_keys_in_map
       'start':(_)=>const Start(),
     },
      theme: ThemeData(
        primaryColor: Colors.blue.shade200,
        primaryColorDark: Colors.blue.shade200,
      ),
    );
  }
}
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
              const Text.rich(TextSpan(text: """“Only he who can see the\n """,style: TextStyle(
                fontSize: 26,color: Colors.white,fontWeight: FontWeight.bold
              ),children: [
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
  }
}




















// class DragGame extends StatefulWidget {
//   @override
//   _DragGameState createState() => new _DragGameState();
// }
//
// class _DragGameState extends State<DragGame> {
//   late int boxNumberIsDragged;
//
//   @override
//   void initState() {
//     boxNumberIsDragged = -1;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         constraints: BoxConstraints.expand(),
//         color: Colors.grey,
//         child: new Stack(
//           children: <Widget>[
//             buildDraggableBox(1, Colors.red, new Offset(30.0, 100.0)),
//             buildDraggableBox(2, Colors.yellow, new Offset(30.0, 200.0)),
//             buildDraggableBox(3, Colors.green, new Offset(30.0, 300.0)),
//           ],
//         ));
//   }
//
//   Widget buildDraggableBox(int boxNumber, Color color, Offset offset) {
//     return Draggable(
//       maxSimultaneousDrags: boxNumberIsDragged == -1 || boxNumber == boxNumberIsDragged ? 1 : 0,
//       child: _buildBox(color, offset),
//       feedback: _buildBox(color, offset),
//       childWhenDragging: _buildBox(color, offset, onlyBorder: true),
//       onDragStarted: () {
//         setState((){
//           boxNumberIsDragged = boxNumber;
//         });
//       },
//       onDragCompleted: () {
//         setState((){
//           boxNumberIsDragged = -1;
//         });
//       },
//       onDraggableCanceled: (_,__) {
//         setState((){
//           boxNumberIsDragged = -1;
//         });
//       },
//     );
//   }
//
//   Widget _buildBox(Color color, Offset offset, {bool onlyBorder: false}) {
//     return  Container(
//       height: 50.0,
//       width: 50.0,
//       margin: EdgeInsets.only(left: offset.dx, top: offset.dy),
//       decoration: BoxDecoration(
//           color: !onlyBorder ? color : Colors.grey,
//           border: Border.all(color: color)),
//     );
//   }
// }
