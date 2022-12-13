import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class GdprDialog extends StatelessWidget {
  const GdprDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.handshake_outlined),
      title: const Text('This is an example GDPR dialog'),
      content: const Text('This application contains Yandex advertising code '
          'that collects data in order to show you relevant ads that better '
          'match your interests. To learn more about how and why Yandex '
          'processes your data, see the Privacy Policy.'),
      actions: [
        TextButton(
          child: const Text('About'),
          onPressed: () async {
            final url = Uri.parse('https://yandex.com/legal/confidential/');
            if (await canLaunchUrl(url)) await launchUrl(url);
          },
        ),
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
