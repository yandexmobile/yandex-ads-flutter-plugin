import 'package:flutter/material.dart';

class LocationDialog extends StatelessWidget {
  const LocationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.place_outlined),
      title: const Text('This is an example location dialog'),
      content: const Text('This application contains Yandex advertising code '
          'that gets your approximate location in order to show you relevant '
          'ads that better match your region.'),
      actions: [
        TextButton(
          child: const Text('Decline'),
          onPressed: () => Navigator.pop(context, false),
        ),
        TextButton(
          child: const Text('Accept'),
          onPressed: () => Navigator.pop(context, true),
        ),
      ],
    );
  }
}
