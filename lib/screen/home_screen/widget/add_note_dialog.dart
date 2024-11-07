import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';

class AddNoteDialog extends StatelessWidget {
  final TextEditingController headlineController;
  final TextEditingController descriptionController;
  final VoidCallback onAddNote;

  const AddNoteDialog({
    super.key,
    required this.headlineController,
    required this.descriptionController,
    required this.onAddNote,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).addNewNote),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: headlineController,
            decoration: InputDecoration(labelText: S.of(context).headline),
          ),
          TextField(
            controller: descriptionController,
            decoration: InputDecoration(labelText: S.of(context).description),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () {
            onAddNote();
            Navigator.of(context).pop();
          },
          child: Text(S.of(context).add),
        ),
      ],
    );
  }
}
