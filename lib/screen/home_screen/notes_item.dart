import 'package:flutter/material.dart';

class NotesItem extends StatefulWidget{
  const NotesItem({super.key});
   
   @override
   State<NotesItem> createState() => _NotesItemState();
   }
  class _NotesItemState extends State<NotesItem> {
    bool isCompleted = false;
  
  @override
  Widget build(BuildContext context) {
    return 
    Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
     IconButton(onPressed: (){
      setState(() {
        isCompleted =! isCompleted;
      });
     },
       icon:  isCompleted
        ? Icon(Icons.check_circle_outline, color: Colors.green) 
        : Icon(Icons.circle_outlined)
       //Icon(Icons.circle_outlined)
      //Icon(Icons.check_circle_outline)
       ),
       SizedBox(width: 8,),
       Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       Title(color: Colors.black, child: Text("ff")),
       Text("ccccccccccc")],),
       SizedBox(width: 8,),
       IconButton(onPressed: (){},
      icon: Icon(Icons.delete)
       ),
    ]);
  }
}