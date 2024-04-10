import 'package:flutter/material.dart';

class NetworkWarningDialog extends StatelessWidget {
  const NetworkWarningDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.warning_amber_outlined),
      title: const Text('Warning'),
      content: const Text('Keep in mind that some ad networks do not work '
          'globally and could not show ads in some regions.\nFor testing '
          'purposes see supported regions for every ad network and use VPN '
          'or other tools to request ads from supported regions.'),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
