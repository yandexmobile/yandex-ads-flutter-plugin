import 'package:flutter/material.dart';
import 'package:yandex_mobileads_sample/constants.dart';

class CoppaDialog extends StatefulWidget {
  const CoppaDialog({super.key});

  @override
  State<CoppaDialog> createState() => _CoppaDialogState();
}

class _CoppaDialogState extends State<CoppaDialog> {
  static const minimumAge = 13;

  var age = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(Icons.child_care_outlined),
      title: const Text('This is an example COPPA dialog'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('This application contains Yandex advertising code that '
              'may show ads that are not suitable for children. Please enter '
              'your age so we can make sure the ads shown are appropriate.'),
          Widgets.verticalSpace,
          TextField(
            decoration: const InputDecoration(
              label: Text('Age'),
            ),
            onChanged: (value) =>
                setState(() => age = int.tryParse(value) ?? 0),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Accept'),
          onPressed: () => Navigator.pop(context, age < minimumAge),
        ),
      ],
    );
  }
}
