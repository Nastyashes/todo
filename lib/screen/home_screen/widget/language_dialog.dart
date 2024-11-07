import 'package:flutter/material.dart';
import 'package:todo/generated/l10n.dart';

class LanguageDialog extends StatelessWidget {
  final Function(Locale) changeLanguage;

  const LanguageDialog({super.key, required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(Icons.language),
      onSelected: (value) {
        if (value == 1) {
          changeLanguage(const Locale('uk'));
        } else if (value == 2) {
          changeLanguage(const Locale('en'));
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
              Text(S.of(context).ua),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 2,
          child: Row(
            children: [
              const Icon(
                Icons.language,
                color: Colors.grey,
              ),
              const SizedBox(width: 8),
              Text(S.of(context).en),
            ],
          ),
        ),
      ],
    );
  }
}
