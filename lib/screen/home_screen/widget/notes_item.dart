import 'package:flutter/material.dart';
import 'package:todo/screen/home_screen/widget/notes.dart';

class NotesItem extends StatelessWidget {
  final List<Notes> notesList;
  final Function(int) onToggleCompleted;
  final Function(String) onDeleteNote;

  const NotesItem(
      {super.key,
      required this.notesList,
      required this.onToggleCompleted,
      required this.onDeleteNote});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notesList.length,
      itemBuilder: (context, index) {
        Notes note = notesList[index];
        return Container(
          decoration: const BoxDecoration(
              
              border: BorderDirectional(
                  bottom: BorderSide(color:Color.fromARGB(255, 78, 212, 134),))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () => onToggleCompleted(index),
                icon: note.isCompleted
                    ? const Icon(Icons.check_circle_outline,
                        color: Color.fromARGB(255, 78, 212, 134))
                    : const Icon(Icons.circle_outlined),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                        note.headline,
                        style: const TextStyle(
                          fontSize: 18,
                          
                        ),
                      ),
                  Text(
                    note.description,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => onDeleteNote(note.id),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        );
      },
    );
  }
}
