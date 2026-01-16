 import 'package:flutter/material.dart';
 import 'package:flutter/rendering.dart'; 
 import 'package:hive_flutter/hive_flutter.dart'; 
  
 import '../models/task.dart'; 
 import 'month.dart'; 
  
 class TasksPage extends StatefulWidget { 
   const TasksPage({Key? key}) : super(key: key); 
  
   @override 
   State<TasksPage> createState() => _TasksPageState(); 
 } 
  
 class _TasksPageState extends State<TasksPage> { 
   double? _deviceHeight, _deviceWidth; 
   String? content; 
   Box? _box; 
  
   @override 
   Widget build(BuildContext context) { 
     _deviceHeight = MediaQuery.of(context).size.height; 
     _deviceWidth = MediaQuery.of(context).size.width; 
     return Scaffold( 
       appBar: AppBar( 
         toolbarHeight: _deviceHeight! * 0.1, 
         title: const Text("Daily Planner"), 
       ), 
       body: _tasksWidget(), 
       floatingActionButton: FloatingActionButton( 
         onPressed: displayTaskPop, 
         child: Icon(Icons.add), 
       ), 
     ); 
   } 
  
   Widget _todoList() { 
     List tasks = _box!.values.toList(); 
     List fullMonth = months().values.toList(); 
  
     return ListView.builder( 
         itemCount: tasks.length, 
         itemBuilder: (BuildContext context, int index) { 
           var task = Task.fromMap(tasks[index]); 
           return ListTile( 
             title: Text( 
               task.todo, 
               style: TextStyle( 
                   decoration: task.done ? TextDecoration.lineThrough : null), 
             ), 
             subtitle: Text( 
             "${task.timeStamp.day}th ${fullMonth.elementAt(task.timeStamp.month - 1)}, ${task.timeStamp.year} ${task.timeStamp.hour > 12 ? task.timeStamp.hour - 12 : task.timeStamp.hour}:${task.timeStamp.minute < 10 ? '0${task.timeStamp.minute}' : task.timeStamp.minute} ${task.timeStamp.hour > 12 ? 'PM' : 'AM'}", 
               style: TextStyle( 
                 decoration: task.done ? TextDecoration.lineThrough : null 
               ), 
             ), 
  
             trailing: task.done 
                 ? Icon( 
                     Icons.check_box_outlined, 
                     color: Colors.green, 
                   ) 
                 : Icon(Icons.check_box_outline_blank), 
             onTap: () { 
               task.done = !task.done; 
               _box!.putAt(index, task.toMap()); 
               setState(() {}); 
             }, 
             onLongPress: () { 
               showDialog( 
                   context: context, 
                   builder: (BuildContext context) { 
                     return AlertDialog( 
                       title: Text("Delete Task?"), 
                       content: SingleChildScrollView( 
                         child: Text("Would you like to delete this task?"), 
                       ), 
                       actions: [ 
                         TextButton( 
                             onPressed: () { 
                               _box!.deleteAt(index); 
                               setState(() {}); 
                               Navigator.pop(context, "Yes"); 
                             }, 
                             child: const Text("Yes")), 
                         TextButton( 
                             onPressed: () { 
                               Navigator.pop(context, "No"); 
                             }, 
                             child: const Text("No")), 
                       ], 
                     ); 
                   }); 
             }, 
           ); 
         }); 
   } 
  
   Widget _tasksWidget() { 
     return FutureBuilder( 
         future: Hive.openBox("tasks"), 
         builder: (BuildContext context, AsyncSnapshot snapshot) { 
           if (snapshot.hasData) { 
             _box = snapshot.data; 
             return _todoList(); 
           } else { 
             return Center(child: const CircularProgressIndicator()); 
           } 
         }); 
   } 
  
   void displayTaskPop() { 
     showDialog( 
         context: context, 
         builder: (BuildContext _context) { 
           return AlertDialog( 
             title: const Text("Add a ToDo"), 
             content: TextField( 
               onSubmitted: (value) { 
                 if (content != null) { 
                   var task = Task( 
                       todo: content!, timeStamp: DateTime.now(), done: false); 
                   _box!.add(task.toMap()); 
                   setState(() { 
                     print(value); 
                     Navigator.pop(context); 
                   }); 
                 } 
               }, 
               onChanged: (value) { 
                 setState(() { 
                   content = value; 
                   print(value); 
                 }); 
               }, 
             ), 
           ); 
         }); 
   } 
 }