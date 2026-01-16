import 'package:flutter/material.dart'; 
import 'package:smooth_page_indicator/smooth_page_indicator.dart'; 
  
 class IntroPage extends StatefulWidget { 
   const IntroPage({Key? key}) : super(key: key); 
  
   @override 
   State<IntroPage> createState() => _IntroPageState(); 
 } 
  
 class _IntroPageState extends State<IntroPage> { 
   PageController _controller = PageController(); 
   bool onLastPage = false; 
  
   @override 
   Widget build(BuildContext context) { 
     return Scaffold( 
         body: Stack( 
           children: [ 
             PageView( 
               controller: _controller, 
               onPageChanged: (index) { 
                 setState(() { 
                   onLastPage = (index == 2); 
                   print("$index, $onLastPage"); 
                 }); 
               }, 
               children: [ 
                 Container( 
                   color: Colors.yellow, 
                   child: Image.asset('assets/images/sleep.png'), 
                 ), 
                 Container( 
                   color: Colors.yellow, 
                   child: Image.asset('assets/images/exercise.png'), 
                 ), 
                 Container( 
                   color: Colors.yellow, 
                   child: Image.asset('assets/images/work.png'), 
                 ) 
               ], 
             ), 
             Container( 
               alignment: Alignment(0, 0.85), 
               child: Row( 
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
                 children: [ 
                   GestureDetector( 
                     onTap: () { 
                       Navigator.pushNamed(context, 'tasks'); 
                     }, 
                     child: Text( 
                       'skip', 
                       style: TextStyle(color: Colors.grey), 
                     ), 
                   ), 
                   SmoothPageIndicator( 
                     controller: _controller, 
                     count: 3, 
                     effect: SwapEffect( 
                         dotColor: Colors.blue, 
                         activeDotColor: Colors.white, 
                         type: SwapType.yRotation), 
                   ), 
                   onLastPage 
                       ? GestureDetector( 
                       onTap: () { 
                         Navigator.pushNamed(context, 'tasks'); 
                       }, 
                       child: Text('done', style: TextStyle(color: Colors.grey))) 
                       : GestureDetector( 
                     onTap: () { 
                       _controller.nextPage( 
                           duration: Duration(milliseconds: 500), 
                           curve: Curves.easeIn); 
                     }, 
                     child: Icon( 
                       Icons.arrow_forward, 
                       color: Colors.grey, 
                     ), 
                   ) 
                 ], 
               ), 
             ) 
           ], 
         )); 
   } 
 }