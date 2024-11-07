import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/firebase_service.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/home_screen/language_dialog.dart';
import 'package:todo/screen/home_screen/notes_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user, required this.changeLanguage});
  
  final User user;
  final Function(Locale) changeLanguage;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<String> sort;
  String? selectedSort;

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButton<String>(
          hint: Text(S.of(context).sortBy),
          value: selectedSort,
          onChanged: (String? newValue) {
            setState(() {
              selectedSort = newValue;
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
            onPressed: () {}, 
            icon: const Icon(Icons.add),
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
                value: 0, enabled: false, child: Text('mail: ${widget.user.email}')),
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
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: NotesItem(),
          ),
        ],
      ),
    );
  }
}