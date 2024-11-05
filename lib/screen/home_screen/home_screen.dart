import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';
import 'package:todo/screen/home_screen/notes_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
          onPressed:() {}, icon: const Icon(Icons.add), ),
          PopupMenuButton<int>(
            icon: const Icon(Icons.language),
            onSelected: (value) {
              if (value == 1) {
                // authControler.logout();
              }
              if (value == 2) {
                // authControler.logout();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                  value: 1,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.language,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(S.of(context).ua)
                    ],
                  )),
              PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.language,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Text(S.of(context).en)
                    ],
                  ))
            ],
          ),
        ],
        leading: PopupMenuButton<int>(
          icon: const Icon(Icons.person),
          onSelected: (value) {
            if (value == 1) {
              // authControler.logout();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
                value: 0, enabled: false, child: Text('user@mail.com')),
            PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: [
                    const Icon(
                      Icons.logout,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Text(S.of(context).logout)
                  ],
                ))
          ],
        ),
      ),
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(horizontal: 20),
          child: NotesItem(),),
       ],
      ),
    );
  }
}
