import 'package:to_do_list/screens/intro_screen.dart'; 
import 'package:to_do_list/screens/tasks_page.dart'; 
import 'package:flutter/material.dart'; 
import 'package:hive_flutter/hive_flutter.dart'; 
  
 void main() async{ 
   await Hive.initFlutter("hive_box"); 
   runApp(const MyApp()); 
 } 
  
 class MyApp extends StatelessWidget { 
   const MyApp({super.key}); 
  
   // This widget is the root of your application. 
   @override 
   Widget build(BuildContext context) { 
     return MaterialApp( 
       title: 'Flutter Demo', 
       theme: ThemeData( 
         primarySwatch: Colors.blue, 
       ), 
       initialRoute: 'intro', 
        routes: { 
         'intro': (context) => IntroPage(), 
          'tasks':(context) => TasksPage(), 
        }, 
     ); 
   } 
 }