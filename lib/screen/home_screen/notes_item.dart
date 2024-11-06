import 'package:flutter/material.dart';
import 'package:todo/screen/entities/notes.dart';

class NotesItem extends StatefulWidget{
  const NotesItem({super.key});
   
   @override
   State<NotesItem> createState() => _NotesItemState();
   }
  class _NotesItemState extends State<NotesItem> {
    bool isCompleted = false;
    Notes?  notes;

  
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
        ? const Icon(Icons.check_circle_outline, color: Colors.green) 
        : const Icon(Icons.circle_outlined)
       ),
       const SizedBox(width: 8,),
       Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
       Title(color: Colors.black, child: Text('${notes?.headline}')),
       Text('${notes?.description}')],),
       const SizedBox(width: 8,),
       IconButton(onPressed: (){},
      icon: const Icon(Icons.delete)
       ),
    ]);
  }
}