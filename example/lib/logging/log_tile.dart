/*
 * This file is a part of the Yandex Advertising Network
 *
 * Version for Flutter (C) 2022 YANDEX
 *
 * You may not use this file except in compliance with the License.
 * You may obtain a copy of the License at https://legal.yandex.com/partner_ch/
 */

import 'package:flutter/material.dart';

class LogTile extends StatelessWidget {
  final String log;
  final Widget button;

  const LogTile({
    Key? key,
    required this.log,
    required this.button,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.text_snippet_outlined),
          title: const Text('Logs'),
          trailing: button,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(log),
            ),
          ),
        ),
      ],
    );
  }
}
