import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/database/database.dart';
import 'package:todo/firebase_service.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/home_screen/widget/add_note_dialog.dart';
import 'package:todo/screen/home_screen/widget/notes.dart';
import 'package:todo/screen/home_screen/widget/language_dialog.dart';
import 'package:todo/screen/home_screen/widget/notes_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.user, required this.changeLanguage});

  final User user;
  final Function(Locale) changeLanguage;


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<String> sort;
  String? selectedSort;
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  List<Notes> notesList = [];
  List<Notes> filteredNotes = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sort = [
      S.of(context).allNotes,
      S.of(context).notFulfilled,
      S.of(context).completed,
    ];
  }

  @override
  void dispose() {
    _headlineController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

 void _addNote() async {
  if (_headlineController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
    setState(() {
      final newNote = Notes(
        id: '', 
        userId: widget.user.uid,
        headline: _headlineController.text,
        description: _descriptionController.text,
        isCompleted: false,
      );

      DatabaseService().addNewNote(newNote).then((_) {
       
        notesList.add(newNote);  
        _applyFilter(selectedSort); 
        _headlineController.clear();
        _descriptionController.clear();
      }).catchError((e) {
        if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding note: $e')));
      }});
    });
  }
}

 void _deleteNote(String noteId) async {
    setState(() {
      notesList.removeWhere((note) => note.id == noteId);
      _applyFilter(selectedSort);
    });

   
    DatabaseService().deleteNote(noteId).catchError((e) { {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding note: $e'))
        );
      }}});
  }

  void _toggleCompleted(int index) {
  setState(() {
  
    notesList[index].isCompleted = !notesList[index].isCompleted;
    _applyFilter(selectedSort); 
  });

  
  DatabaseService().updateNoteCompletion(
    notesList[index].id, 
    notesList[index].isCompleted,
  ).catchError((e) {
    if (mounted) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error updating note: $e')));
  }});
}


  void _applyFilter(String? filter) {
    if (filter == null) {
      filteredNotes = notesList;
    } else if (filter == S.of(context).allNotes) {
      filteredNotes = notesList;
    } else if (filter == S.of(context).completed) {
      filteredNotes = notesList.where((note) => note.isCompleted).toList();
    } else if (filter == S.of(context).notFulfilled) {
      filteredNotes = notesList.where((note) => !note.isCompleted).toList();
    }
  }

  void _openAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddNoteDialog(
          headlineController: _headlineController,
          descriptionController: _descriptionController,
          onAddNote: _addNote,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          hint: Text(S.of(context).sortBy),
          value: selectedSort,
          onChanged: (String? newValue) {
            setState(() {
              selectedSort = newValue;
              _applyFilter(newValue); 
            });
          },
          items: sort.map((String sort) {
            return DropdownMenuItem<String>(
              value: sort,
              child: Text(sort),
            );
          }).toList(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddNoteDialog,
          ),
          LanguageDialog(changeLanguage: widget.changeLanguage),
        ],
        leading: PopupMenuButton<int>(
          icon: const Icon(Icons.person),
          onSelected: (value) {
            if (value == 1) {
              FirebaseService().logOut();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<int>(
                value: 0,
                enabled: false,
                child: Text('mail: ${widget.user.email}')),
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Colors.grey),
                  const SizedBox(width: 8),
                  Text(S.of(context).logout)
                ],
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<List<Notes>>(
        stream: DatabaseService().getNotes(userId: widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(S.of(context).noNotes));
          }

        
          notesList = snapshot.data!;
          _applyFilter(selectedSort);

          return NotesItem(
            notesList: filteredNotes, 
            onToggleCompleted: _toggleCompleted, onDeleteNote: _deleteNote, 
            
          );
        },
      ),
    );
  }
}
